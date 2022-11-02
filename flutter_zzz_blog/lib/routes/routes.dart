import 'package:flutter/material.dart';
import 'package:flutter_zzz_blog/detail/detail_page.dart';
import 'package:flutter_zzz_blog/home/home_page.dart';

class RoutesName {
  static const String HomePageRoute = '/'; //首页

  static const String DetailPageRoute = '/DetailPage'; //详情页
}

// class Routes {
//   static List<GetPage<dynamic>> pages() {
//     return [
//       GetPage(name: '/', page: () => HomePage()),
//       GetPage(
//         name: RoutesName.DetailPageRoute,
//         page: () => DetailPage(url: "assets/md/flutter_anmation.md"),
//         transition: PlatformDetector.isAllMobile ? Transition.cupertino : Transition.noTransition,
//       ),
//     ];
//   }
// }

final Map<String, Function> routes = {
  RoutesName.HomePageRoute: (context) => HomePage(),
  RoutesName.DetailPageRoute: (context, {arguments}) => DetailPage(url: arguments['url']),
};

var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name ?? "";
  final pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(builder: (context) => pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route = MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return null;
};
