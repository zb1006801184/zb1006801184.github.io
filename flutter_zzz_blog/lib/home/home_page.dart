import 'package:flutter/material.dart';
import 'package:flutter_zzz_blog/home/home_mixins.dart';
import 'package:flutter_zzz_blog/models/home.dart';
import 'package:flutter_zzz_blog/widges/common_widget_mixin.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_zzz_blog/routes/routes.dart';

///cell的高度
const double cellHeight = 90.0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with CommonWidgetMixin, HomeMixin {
  List<HomeModel> dataList = [];

  @override
  void initState() {
    super.initState();
    loadData().then((value) {
      setState(() {
        dataList = value;
      });
    });
  }

  void _cellItemClick({int? index}) {
    if (index == null) return;
    GoRouter.of(context).go(
      RoutesName.DetailPageRoute,
      extra: {'url': dataList[index].url ?? ''},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // topWidget(),
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
              child: _cellWidget(index: index),
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
  Widget _cellWidget({int? index}) {
    HomeModel _model = dataList[index ?? 0];
    return Container(
      padding: EdgeInsets.only(top: 44),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(_model.image ?? ""),
                fit: BoxFit.contain,
              ),
            ),
            width: 160,
            height: cellHeight,
          ),
          Container(width: 10),
          Container(
            constraints: BoxConstraints(maxWidth: 330),
            height: cellHeight,
            child: _textWidget(index: index),
          ),
        ],
      ),
    );
  }

  ///标题 描述
  Widget _textWidget({int? index}) {
    HomeModel? _model = index == null ? null : dataList[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            _model?.title ?? "",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 5),
        Container(
          child: Text(
            _model?.describe ?? "",
            style: TextStyle(
                fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 5),
        Container(
          child: Text(
            _model?.date ?? "",
            style: TextStyle(
                fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
