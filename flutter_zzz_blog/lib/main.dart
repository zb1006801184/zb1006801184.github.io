import 'package:flutter/material.dart';
import 'package:flutter_zzz_blog/routes/routes.dart';

import 'home/home_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'zzz',
    theme: ThemeData(primaryColor: Color(0xFFFFFFFF)),
    initialRoute: '/',
    onGenerateRoute: onGenerateRoute,
    home: HomePage(),
  ));
}
