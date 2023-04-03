import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/entry/NewsBean.dart';
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class NewRoute extends StatefulWidget{
  const NewRoute({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  _NewRouteState createState() {
    // TODO: implement createElement
    return _NewRouteState();
  }
}
class _NewRouteState extends State<NewRoute> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    var dio = Dio(BaseOptions(baseUrl: "http://api.iclient.ifeng.com"));
    Future<NewsBean> getNews({ Map<String, dynamic>? queryParameters}) async {
      var result = await dio.get("/ClientNews?id=${widget
          .type}&pullNum=1&uid=864678036850608&action=default",
          queryParameters: queryParameters);
      print("接口返回数据:/ClientNews?id=${widget
          .type}&pullNum=1&uid=864678036850608&action=default");
      return getNewsBeanList(result.data).first;
    }
    return Center(
      child: FutureBuilder(
          future: getNews(),
          builder: (BuildContext context, AsyncSnapshot<NewsBean> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    var item = snapshot.data?.item[index];
                    if (index == 0 && item?.type == "focus") {
                      var list = snapshot.data?.item.map((e) => e.thumbnail)
                          .toList();
                      return Swiper(
                        itemCount: list?.length,
                        itemBuilder: (context, index) {
                          return Image.network(list![index]);
                        },
                      );
                    } else
                    if (item?.type == "doc" && item?.style.view == "titleimg") {
                      return Column(
                        children: [
                          ListTile(
                            leading: Image.network(item!.thumbnail, width: 100,
                              height: 80,
                              fit: BoxFit.cover,),
                            title: Text(item.title, style: const TextStyle(
                                fontSize: 14),),
                            subtitle: Text(item.title, style: const TextStyle(
                                fontSize: 10),),
                          ),
                          const Divider(color: Colors.black38,
                            height: 2,
                            indent: 16,
                            endIndent: 16,)
                        ],
                      );
                    }
                    else
                    if (item?.type == "doc" && item?.style.view == "slideimg") {
                      return Column(

                      );
                    } else {
                      return Container();
                    }
                  });
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

