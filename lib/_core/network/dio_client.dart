import 'package:delivery_boy/features/region/repository/region_repo.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:dio/dio.dart';

export 'package:dio/dio.dart' show DioException;

class DioClient {
  DioClient({this.useEvent = true}) {
    _dio = Dio(_options);
    _dio.interceptors.add(_interceptorsWrapper());
    _dio.interceptors.add(Logger.dioLogger());
  }

  final bool useEvent;

  final _ls = locate<LocalDB>();
  final _options = BaseOptions(
    baseUrl: Endpoints.api,
    connectTimeout: Endpoints.connectionTimeout,
    receiveTimeout: Endpoints.receiveTimeout,
    responseType: ResponseType.json,
    headers: {'Accept': 'application/json'},
  );

  late Dio _dio;

  Future<Map<String, String?>> header() async {
    final token = _ls.getString(PrefKeys.accessToken);
    final lang = locate<RegionRepo>().getLanguage();
    final cur = locate<RegionRepo>().getCurrency()?.uid;

    return {
      'Authorization': 'Bearer $token',
      'currency-uid': cur,
      'api-lang': lang,
    };
  }

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final formData = data == null
          ? null
          : FormData.fromMap(data, ListFormat.multiCompatible);

      final response = await _dio.post(
        url,
        data: formData,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Interceptors :----------------------------------------------------------------------
  _interceptorsWrapper() => InterceptorsWrapper(
        onRequest: (options, handler) async {
          final headers = await header();
          options.headers.addAll(headers);
          return handler.next(options);
        },
        onResponse: (res, handler) {
          final regionRepo = locate<RegionRepo>();
          regionRepo.setFromResponse(res);

          final data = res.data;

          if (data case {'code': int code}) {
            if (useEvent) eventBus.fire(ServerEvent(code));
          }

          return handler.next(res);
        },
        onError: (error, handler) async {
          final data = error.response?.data;

          if (data case {'message': String msg}) {
            final contains = msg.lc.contains('unauthenticated');
            if (contains) eventBus.fire(UnAuthEvent(msg));
          }
          if (data case {'code': int code}) {
            if (useEvent) eventBus.fire(ServerEvent(code));
          }

          return handler.next(error);
        },
      );
}
