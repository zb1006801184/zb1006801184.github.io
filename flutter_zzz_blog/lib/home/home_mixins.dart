import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_zzz_blog/models/home.dart';

mixin HomeMixin {
  //加载本地数据
  Future<List<HomeModel>> loadData() async {
    String jsonString = await rootBundle.loadString("assets/datas/home.json");
    final jsonResult = json.decode(jsonString);
    List<HomeModel> result = [];
    for (var item in jsonResult) {
      result.add(HomeModel.fromJson(item));
    }
    return Future.value(result);
  }
}
