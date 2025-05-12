import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoute extends GoRoute {
  AppRoute(
    String path,
    Widget Function(GoRouterState s) builder, {
    List<GoRoute> routes = const [],
    super.redirect,
    Function()? onPop,
    bool canPop = true,
    super.parentNavigatorKey,
  }) : super(
          path: path,
          onExit: (c, s) {
            onPop?.call();
            return canPop;
          },
          name: buildName(path),
          routes: routes,
          pageBuilder: (context, state) {
            final pageContent = builder(state);

            return CustomTransitionPage(
              key: state.pageKey,
              child: pageContent,
              transitionsBuilder: (__, animation, _, child) => FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );

  static String buildName(String path) {
    final parts = path.split('/');
    final last = parts.last;
    if (!last.startsWith(':')) return last;
    return parts[parts.length - 2];
  }
}
