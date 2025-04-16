import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension RouteEx on BuildContext {
  GoRouter get route => GoRouter.of(this);
  GoRouterState get routeState => GoRouterState.of(this);

  Map<String, String> get pathParams => routeState.pathParameters;
  String? param(String key) => pathParams[key];
  Map<String, String> get queryParams => routeState.uri.queryParameters;
  String? query(String key) => queryParams[key];

  void nPop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);
  void nPush<T extends Object?>(Widget page, {bool? isFullScreen}) {
    final route = MaterialPageRoute(
      builder: (c) => page,
      fullscreenDialog: isFullScreen ?? false,
    );
    Navigator.of(this).push(route);
  }

  Future<T?> pushQuery<T extends Object?>(
    String location, {
    QMap? queryParameters,
    Object? extra,
  }) {
    final uri = Uri(path: location, queryParameters: queryParameters);
    return GoRouter.of(this).push<T>(uri.toString(), extra: extra);
  }

  void goQuery(
    String location, {
    QMap? queryParameters,
    Object? extra,
  }) {
    final uri = Uri(path: location, queryParameters: queryParameters);
    return GoRouter.of(this).go(uri.toString(), extra: extra);
  }
}

extension ContextEx on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);

  Size get size => MediaQuery.sizeOf(this);
  double get height => size.height;
  double get width => size.width;

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorTheme => theme.colorScheme;

  Brightness get bright => theme.brightness;

  bool get isDark => bright == Brightness.dark;
  bool get isLight => bright == Brightness.light;
  TR get tr => TR.of(this);
}
