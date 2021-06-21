import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 44),
              child: FutureBuilder(
                future: rootBundle.loadString('assets/md/flutter_anmation.md'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Markdown(
                      data: snapshot.data,
                      onTapLink: (s, b, c) {
                        print(s + b + c);
                      },
                    );
                  } else {
                    return Center(
                      child: Text("加载中..."),
                    );
                  }
                },
              ),
            ),
            flex: 3,
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
