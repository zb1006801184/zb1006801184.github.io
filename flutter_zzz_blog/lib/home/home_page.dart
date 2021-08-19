import 'package:flutter/material.dart';
import 'package:flutter_zzz_blog/routes/routes.dart';
import 'package:flutter_zzz_blog/widges/common_widget_mixin.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

///cell的高度
const double cellHeight = 90.0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with CommonWidgetMixin {
  List dataList = ['1', '2', '3'];
  void _cellItemClick({int? index}) {
    Get.toNamed(RoutesName.DetailPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topWidget(),
          _listWidget(),
        ],
      ),
    );
  }

  ///列表
  Widget _listWidget() {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: _cellWidget(),
              onTap: () {
                _cellItemClick(index: index);
              },
            );
          },
        ),
      ),
    );
  }

  ///列表 cell
  Widget _cellWidget() {
    return Container(
      padding: EdgeInsets.only(top: 44),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            width: 160,
            height: cellHeight,
          ),
          Container(width: 10),
          Container(
            constraints: BoxConstraints(maxWidth: 330),
            height: cellHeight,
            child: _textWidget(),
          ),
        ],
      ),
    );
  }

  ///标题 描述
  Widget _textWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            '我是标题啊',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 5),
        Container(
          child: Text(
            '我是描述描述我是描述描述我是描述描述我是描述描述我是描述描述我是描述描述我是描述描述我是描述描述我是描述描述我是描述描述我是描述描述我是描述描述我是描述描述我是描述描述我是描述描述我是描述描述',
            style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 5),
        Container(
          child: Text(
            '2021-06-21',
            style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
