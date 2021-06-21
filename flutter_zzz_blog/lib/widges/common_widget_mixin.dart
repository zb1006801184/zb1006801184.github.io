import 'package:flutter/material.dart';

mixin CommonWidgetMixin {
  ///页面的顶部widget
  Widget topWidget() {
    return Container(
      width: double.infinity,
      height: 88,
      color: Colors.red,
    );
  }
}
