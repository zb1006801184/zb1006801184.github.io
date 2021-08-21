import 'package:flutter/foundation.dart';
import 'package:flutter_zzz_blog/detail/detail_page.dart';
import 'package:flutter_zzz_blog/home/home_page.dart';
import 'package:flutter_zzz_blog/platform_dector/platform_dector.dart';
import 'package:get/route_manager.dart';

class RoutesName {
  static const String DetailPageRoute = '/DetailPage'; //详情页
}

class Routes {
  static List<GetPage<dynamic>> pages() {
    return [
      GetPage(name: '/', page: () => HomePage()),
      GetPage(
        name: RoutesName.DetailPageRoute,
        page: () => DetailPage(url: "assets/md/flutter_anmation.md"),
        transition: PlatformDetector.isAllMobile
            ? Transition.cupertino
            : Transition.noTransition,
      ),
    ];
  }
}
