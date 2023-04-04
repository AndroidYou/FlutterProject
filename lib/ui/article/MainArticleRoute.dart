import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterproject/entry/MainBanner.dart';
import 'package:flutterproject/net/NetCode.dart';
import 'package:flutterproject/utlis/DateFormat.dart';

import '../../entry/ArticleList.dart';
import 'package:http/http.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../net/api_manager.dart';

class MainArticleRoute extends StatefulWidget {
  const MainArticleRoute({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainArticleRoute();
}

class _MainArticleRoute extends State<MainArticleRoute> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("response1:开始请求}");
    getBanner();
  }

  List<BannerBean> banner = [];

  getBanner() async {
    Response response = await ApiManager.getMainBanner();
    print("response1:${response.statusCode}");
    if (response.statusCode == NetCode.succeed) {
      banner.addAll(MainBanner.fromJson(jsonDecode(response.body)).data);
      setState(() {});
    }
  }

  Future<List<DatasBean>> _getArticles() async {
    Response response = await ApiManager.getMainArticleList();
    print("response:${response.statusCode}");
    return ArticleList.fromJson(jsonDecode(response.body)).data.datas;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: _getArticles(),
          builder:
              (BuildContext context, AsyncSnapshot<List<DatasBean>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.separated(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  var data = snapshot.data?.toList()[index];
                  if (banner.isNotEmpty && index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200,
                          child: Swiper(
                            itemCount: banner.length,
                            itemHeight: 200,
                            itemBuilder: (BuildContext context, int index) {
                              return _BannerItem(banner[index]);
                            },
                          ),
                        ),
                      _ArticleItem(data!)
                      ],
                    );
                  } else {
                    return  _ArticleItem(data!);
                  }
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                    child: Divider(
                      color: Color(0xFFF6F1F1),
                      thickness: 10,
                    ),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
///banner item布局
class _BannerItem extends StatelessWidget {
  const _BannerItem(this._bannerBean);

  final BannerBean _bannerBean;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.network(_bannerBean.imagePath, fit: BoxFit.cover),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
              color: Colors.black26,
            ),
            child: Text(
              _bannerBean.title,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
///列表item
class _ArticleItem extends StatelessWidget{
  const _ArticleItem(this._bean);
  final DatasBean _bean;
  @override
  Widget build(BuildContext context) {

    return  ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 120
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
            const Padding(padding: EdgeInsets.all(10),child:Icon(Icons.person,color: Colors.blue,) ,),Padding(padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Text(DateFormat.format(DateTime.parse(_bean.niceShareDate)),style: const TextStyle(fontSize: 12,color: Colors.black12),),)
          ],),
          Padding(padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),child: Text(_bean.title,style: const TextStyle(fontSize: 18),),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
              Padding(padding: const EdgeInsets.all(10),child:  Text(_bean.chapterName,style: const TextStyle(color: Colors.blue,fontSize: 14),),),
             const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0),child:  Icon(Icons.heart_broken,color: Colors.red,),)
            ],
          )
        ],
      ),
    );
  }

}
