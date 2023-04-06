import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterproject/entry/KnowledgeItemBean.dart';
import 'package:flutterproject/net/api_manager.dart';
import 'package:flutterproject/utlis/DateFormat.dart';
import 'package:http/http.dart';

import '../article/DetailArticleRoute.dart';

class KnowledgeItem extends StatefulWidget {
  const KnowledgeItem({Key? key, required this.cid}) : super(key: key);
  final int cid;

  @override
  _KnowledgeItemState createState() {
    return _KnowledgeItemState();
  }

}

class _KnowledgeItemState extends State<KnowledgeItem> with AutomaticKeepAliveClientMixin{

  Future<List<DatasBean>> _getItemList() async{
    print("获取数据1:${widget.cid}");
   Response response = await ApiManager.getKnowledgeList(widget.cid);
    print("获取数据:${response.statusCode}");
    return KnowledgeItemBean.fromJson(jsonDecode(response.body)).data.datas;
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: _getItemList(),
          builder: (BuildContext context,
          AsyncSnapshot<List<DatasBean>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.separated(itemBuilder: (context, index) {
            return ItemView(datasBean: snapshot.data![index]);
          },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.white,
                  thickness: 10,
                );
              },
              itemCount: snapshot.data!.length);
        } else {
          return const CircularProgressIndicator();
        }
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;

}

class ItemView extends StatelessWidget {
  const ItemView({Key? key, required this.datasBean}) : super(key: key);
  final DatasBean datasBean;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
            minHeight: 120
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(padding: EdgeInsets.all(20),
                  child: Icon(Icons.person, color: Colors.blue,),),
                Padding(padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child:Text( datasBean.niceDate,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.black38),),)
              ],),
            Padding(padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                datasBean.title, style: const TextStyle(fontSize: 18),),),
            const Align(alignment:Alignment.centerRight,child: Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Icon(Icons.heart_broken, color: Colors.red,),),)
          ],
        ),

      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            DetailArticleRoute(url: datasBean.link, title: datasBean.title)));
      },
    );
  }

}