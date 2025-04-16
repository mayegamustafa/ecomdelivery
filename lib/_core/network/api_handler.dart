import 'dart:io';

import 'package:delivery_boy/main.export.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

mixin ApiHandler {
  FutureReport<BaseResponse<T>> apiCallHandler<T>({
    required Future<Response> Function() call,
    required T Function(Map<String, dynamic> map) mapper,
  }) async {
    try {
      final Response(:statusCode, :data) = await call.call();

      if (statusCode != null && statusCode >= 200 && statusCode < 300) {
        final map = data;

        if ('${map['status']}' != 'SUCCESS') {
          return failure('${map['message']}', data);
        }

        return right(BaseResponse.fromMap(map, mapper));
      } else {
        return failure('Call ended with code $statusCode', data);
      }
    } on SocketException catch (e, st) {
      return failure(e.message, e, st);
    } on DioException catch (e, st) {
      return left(DioExp(e).toFailure(st));
    } on Failure catch (e, st) {
      return left(e.copyWith(stackTrace: st));
    } catch (e, st) {
      return failure('$e', e, st);
    }
  }
}
