
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterproject/entry/Channel.dart';
import 'package:flutterproject/ui/new/NewRoute.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  _HomeRouteState createState() {
    // TODO: implement createElement
    return _HomeRouteState();
  }
}

class _HomeRouteState extends State<HomeRoute> with TickerProviderStateMixin {
  List<ChoseListBean> titles = [];
  late TabController _controller;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: titles.length, vsync: this);
    initTab();
  }

  void initTab() async {
    titles.clear();
    Future channel = DefaultAssetBundle.of(context).loadString("jsons/channel.json");
    channel.then((value) {
      var map =  jsonDecode(value);
     Channel channel =  Channel.fromJson(map);
     print("输出:${channel.choseList.length}");
     setState(() {
       titles.addAll(channel.choseList);
       _controller = TabController(length: titles.length, vsync: this);
     });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main"),
        centerTitle: true,
        bottom: TabBar(
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: titles.map((e) => Tab(text: e.channelName)).toList(),
          controller: _controller,
        ),
      ),
      body:  TabBarView(
        controller: _controller,
        children: titles.map((e) => NewRoute(type: e.channelNo)).toList(),
      ),
    );
  }
}
