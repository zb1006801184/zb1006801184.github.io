import 'package:flutter/material.dart';
import 'package:flutter_zzz_blog/routes/routes.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'home/home_page.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'zzz的博客',
    theme: ThemeData(primaryColor: Color(0xFFFFFFFF)),
    initialRoute: '/',
    getPages: Routes.pages(),
    home: HomePage(),
  ));
}
