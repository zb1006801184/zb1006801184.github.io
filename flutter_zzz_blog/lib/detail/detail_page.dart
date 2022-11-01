import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_zzz_blog/platform_dector/platform_dector.dart';
import 'package:markdown_widget/markdown_widget.dart';

class DetailPage extends StatefulWidget {
  String? url;
  DetailPage({
    Key? key,
    @required this.url,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (!PlatformDetector.isAllMobile)
            Expanded(flex: 1, child: Container()),
          _markdownWidget(),
          if (!PlatformDetector.isAllMobile)
            Expanded(flex: 1, child: Container()),
        ],
      ),
    );
  }

  Widget _markdownWidget() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 44),
        child: FutureBuilder(
          future: rootBundle.loadString(widget.url ?? ""),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return MarkdownWidget(
                data: snapshot.data,
                styleConfig: StyleConfig(
                  titleConfig: TitleConfig(showDivider: false),
                    pConfig: PConfig(
                      
                      textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),
                      onLinkTap: (url) => print(url),
                    ),
                    videoConfig: VideoConfig(autoInitialize: true)),
              );
            }
            return Center(
              child: Text("加载中..."),
            );
          },
        ),
      ),
      flex: 3,
    );
  }
}
