import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterproject/entry/MainBanner.dart';
import 'package:flutterproject/net/NetCode.dart';

import '../../entry/ArticleList.dart';
import 'package:http/http.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../net/api_manager.dart';

class MainArticleRoute extends StatefulWidget{
  const MainArticleRoute({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainArticleRoute();

}
class _MainArticleRoute extends State<MainArticleRoute>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("response1:开始请求}");
    getBanner();

  }
  List<BannerBean> banner = [];
  getBanner() async{
    Response response =   await ApiManager.getMainBanner();
    print("response1:${response.statusCode}");
    if(response.statusCode == NetCode.succeed){
      banner.addAll(MainBanner.fromJson(jsonDecode(response.body)).data);
      setState(() {
      });
    }

  }
  Future <List<DatasBean>> _getArticles() async{
    Response response = await ApiManager.getMainArticleList();
    print("response:${response.statusCode}");
    return  ArticleList.fromJson(jsonDecode(response.body)).data.datas;
  }
  @override
  Widget build(BuildContext context) {


    return   Center(
        child:


            FutureBuilder(
            future: _getArticles(),
         builder: (BuildContext context,AsyncSnapshot<List<DatasBean>>snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return ListView.separated(
              itemCount:snapshot.data?.length??0,
              itemBuilder: (context,index){
                var data = snapshot.data?.toList()[index];
                return banner.length>0 && index ==0
                Swiper(itemCount: banner.length,
                itemBuilder: (BuildContext context,int index){
                 Image.network(banner[index].url);
                },
                ) :
                  ListTile(
                  title: Text(data?.title??""),
                  subtitle: Text(data?.chapterName??""),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
              return  const SizedBox(height: 10,child: Divider(
                color: Color(0xFFF6F1F1),
                thickness: 10,
              ),);
            },);
          }else{
            return const CircularProgressIndicator();
          }
        }),



    );

  }

}