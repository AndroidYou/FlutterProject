

import 'package:flutter/material.dart';
import 'package:flutterproject/entry/MainKnowledge.dart';
import 'package:flutterproject/ui/knowledge/KnowledgeItem.dart';
class KnowledgeRoute extends StatefulWidget{
  const KnowledgeRoute({Key? key,required this.bean}) : super(key: key);
  final DataBean bean;
  @override
  _KnowledgeRouteState createState() =>_KnowledgeRouteState();

}
class _KnowledgeRouteState extends State<KnowledgeRoute> with SingleTickerProviderStateMixin{
  late TabController _controller;
  @override
  void initState() {
   _controller = TabController(length: widget.bean.children.length, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bean.name),
        actions: const [
          Padding(padding: EdgeInsets.only(right: 10),child: Icon(Icons.search,color: Colors.white,),)
        ],
           bottom: TabBar(
             isScrollable: true,
             indicatorSize:TabBarIndicatorSize.label,
             controller:_controller,tabs: widget.bean.children.map((e) => Tab(text: e.name.toUpperCase())).toList(),
           ),
      ),
      body: TabBarView(
        controller: _controller,
        children: widget.bean.children.map((e) => KnowledgeItem(cid: e.id.toInt())).toList(),
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

