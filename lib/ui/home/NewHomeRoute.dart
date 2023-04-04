import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterproject/view/LeftDrawer.dart';
import '../article/MainArticleRoute.dart';

class NewHomeRoute extends StatefulWidget{
  const NewHomeRoute({Key? key}) : super(key: key);

  @override
  _NewHomeRoute createState() {
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
      drawer:const LeftDrawer(),
    );
  }

}