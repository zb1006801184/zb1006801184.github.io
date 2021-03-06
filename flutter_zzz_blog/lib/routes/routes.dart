import 'package:flutter_zzz_blog/detail/detail_page.dart';
import 'package:flutter_zzz_blog/home/home_page.dart';
import 'package:get/route_manager.dart';

class RoutesName {
  static const String DetailPageRoute = '/DetailPage';
}

class Routes {
  static List<GetPage<dynamic>> pages() {
    return [
      GetPage(name: '/', page: () => HomePage()),
      GetPage(
        name: RoutesName.DetailPageRoute,
        page: () => DetailPage(),
        transition: Transition.noTransition,
      ),
    ];
  }
}
