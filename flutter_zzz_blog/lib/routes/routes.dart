import 'package:flutter/material.dart';
import 'package:flutter_zzz_blog/detail/detail_page.dart';
import 'package:flutter_zzz_blog/home/home_page.dart';
import 'package:go_router/go_router.dart';

class RoutesName {
  static const String HomePageRoute = '/'; //首页

  static const String DetailPageRoute = '/DetailPage'; //详情页
}

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: RoutesName.HomePageRoute,
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: RoutesName.DetailPageRoute,
      // builder: (BuildContext context, GoRouterState state) {
      //   return DetailPage(
      //     url: (state.extra as Map)['url'],
      //   );
      // },
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: DetailPage(
            url: (state.extra as Map)['url'],
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );
      },
    ),
  ],
  initialLocation: RoutesName.HomePageRoute,
);

final Map<String, Function> routes = {
  RoutesName.HomePageRoute: (context) => HomePage(),
  RoutesName.DetailPageRoute: (context, {arguments}) =>
      DetailPage(url: arguments['url']),
};

var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name ?? "";
  final pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return null;
};
