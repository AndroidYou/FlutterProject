import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterproject/entry/MainKnowledge.dart';
import 'package:flutterproject/net/api_manager.dart';
import 'package:flutterproject/ui/knowledge/KnowledgeRoute.dart';
import 'package:http/http.dart';

class MainKnowledgeRoute extends StatefulWidget {
  const MainKnowledgeRoute({Key? key}) : super(key: key);

  @override
  _MainKnowledgeRoute createState() => _MainKnowledgeRoute();
}

class _MainKnowledgeRoute extends State<MainKnowledgeRoute>with AutomaticKeepAliveClientMixin {
  Future<List<DataBean>> _getMainKnowledgeList() async {
    Response response = await ApiManager.getMainKnowledge();
    return MainKnowledge.fromJson(jsonDecode(response.body)).data;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
        future: _getMainKnowledgeList(),
        builder:
            (BuildContext context, AsyncSnapshot<List<DataBean>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
                itemBuilder: (BuildContext context,int index){
                    return _KnowledgeItem(snapshot.data![index]);
                },
                separatorBuilder: (BuildContext context,int index){
                  return const SizedBox(
                    child:Divider(
                      color: Color(0xFFF6F1F1),
                      thickness: 10,
                    ),
                  );
                },
                itemCount: snapshot.data?.length ?? 0);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );

  }

  @override
  bool get wantKeepAlive => true;

}
///子Item
class _KnowledgeItem  extends StatelessWidget{
  const _KnowledgeItem(this._dataBean);
  final DataBean _dataBean;
  @override
  Widget build(BuildContext context) {
   return GestureDetector(
     child:  Row(
       children: [
         Expanded(
           child: Padding(padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),child:  Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(_dataBean.name,style: const TextStyle(fontSize: 18),),
               const SizedBox(height: 20,),
               Wrap(
                   crossAxisAlignment: WrapCrossAlignment.center,
                   children:_dataBean.children.map((e){
                     return Padding(padding: const EdgeInsets.only(right: 10),child: Text(e.name),);
                   }).toList()
               )
             ],
           ),),),
         const Align(
           alignment: Alignment.centerRight,
           child: Icon(Icons.navigate_next),
         )
       ],
     ),
     onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
         return KnowledgeRoute(bean: _dataBean);
       }));
     },
   );
  }

}
