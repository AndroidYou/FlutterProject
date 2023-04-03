import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterproject/entry/ArticleList.dart';
import 'package:flutterproject/entry/NewsBean.dart';
import 'package:flutterproject/net/api_manager.dart';
import 'package:http/http.dart';
import '../article/MainArticleRoute.dart';

class NewHomeRoute extends StatefulWidget{
  const NewHomeRoute({Key? key}) : super(key: key);

  @override
  _NewHomeRoute createState() {
    // TODO: implement createState
    return _NewHomeRoute();
  }
}
class _NewHomeRoute extends State<NewHomeRoute>{
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("玩Android"),
      ),
      body: const MainArticleRoute(),
    );
  }

}