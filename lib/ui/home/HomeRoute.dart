import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterproject/ui/knowledge/MainKnowledgeRoute.dart';
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
  final List<Widget> _pageList = [const MainArticleRoute(),const MainKnowledgeRoute()];
  int currentIndex = 0;
  final List<String> _titleList = ["首页","知识体系"];
  late PageController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: currentIndex);
  }
  @override
  void dispose() {
   _controller.dispose();
   _titleList.clear();
   _pageList.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:  Text(_titleList[currentIndex]),
        actions: const [
          Padding(padding: EdgeInsets.only(right: 10),child: Icon(Icons.search,color: Colors.white,),)
        ],
      ),
      body:PageView(
       controller: _controller,
        children: _pageList,
      ),
      drawer:const LeftDrawer(),
      bottomNavigationBar: BottomNavigationBar(items:  _initItems(),
      currentIndex: currentIndex,
      onTap: (index){
      setState(() {
        currentIndex = index;
        _controller.jumpToPage(currentIndex);
      });
      },),
    );
  }
  List<BottomNavigationBarItem> _initItems(){
    List<BottomNavigationBarItem> barItem =[];
    barItem.add( BottomNavigationBarItem(icon: const Icon(Icons.home),label:_titleList[0]));
    barItem.add( BottomNavigationBarItem(icon: const Icon(Icons.book_outlined),label:_titleList[1]));
     return  barItem;
  }

}