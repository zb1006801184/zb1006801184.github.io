import 'package:flutter/material.dart';
import 'package:flutter_zzz_blog/routes/routes.dart';

void main() {
  // runApp(MaterialApp(
  //   title: 'zzz',
  //   theme: ThemeData(primaryColor: Color(0xFFFFFFFF)),
  //   initialRoute: '/',
  //   onGenerateRoute: onGenerateRoute,
  //   home: HomePage(),
  // ));
  runApp(MaterialApp.router(
    title: 'zzz',
    theme: ThemeData(primaryColor: Color(0xFFFFFFFF)),
    routerConfig: router,
  ));
}
