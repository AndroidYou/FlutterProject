import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterproject/entry/MainBanner.dart';
import 'package:flutterproject/net/NetCode.dart';
import 'package:flutterproject/ui/article/DetailArticleRoute.dart';
import '../../entry/ArticleList.dart';
import 'package:http/http.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../net/api_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MainArticleRoute extends StatefulWidget {
  const MainArticleRoute({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainArticleRoute();
}

class _MainArticleRoute extends State<MainArticleRoute>
    with AutomaticKeepAliveClientMixin {
  final RefreshController _controller =
      RefreshController(initialRefresh: false);
  List<BannerBean> banner = [];
  List<DatasBean> articleList = [];
  int mPage = 0;

  @override
  void initState() {
    super.initState();
    debugPrint("response1:开始请求}");
    _refreshData();
  }

  _getBanner() async {
    Response response = await ApiManager.getMainBanner();
    print("response1:${response.statusCode}");
    if (response.statusCode == NetCode.succeed) {
      banner.clear();
      banner.addAll(MainBanner.fromJson(jsonDecode(response.body)).data);
      setState(() {});
    }
  }

  _getArticles() async {
    Response response = await ApiManager.getMainArticleList(mPage);
    if (response.statusCode == NetCode.succeed) {
      if (mPage == 0) articleList.hashCode;
      articleList
          .addAll(ArticleList.fromJson(jsonDecode(response.body)).data.datas);
    }
    print("response:${response.statusCode}");
  }

  _refreshData() async {
    mPage = 0;
    await _getArticles();
    await _getBanner();
    _controller.refreshCompleted();
  }

  _loadingData() async {
    mPage++;
    await _getArticles();
    await _getBanner();
    _controller.loadComplete();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: SmartRefresher(
        controller: _controller,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _refreshData,
        onLoading: _loadingData,
        child: ListView.separated(
          itemCount: articleList.length,
          itemBuilder: (context, index) {
            var data = articleList[index];
            if (banner.isNotEmpty && index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200,
                    child: Swiper(
                      itemCount: banner.length,
                      itemHeight: 200,
                      onTap: (index) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailArticleRoute(
                                    url: banner[index].url,
                                    title: banner[index].title)));
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return _BannerItem(banner[index]);
                      },
                    ),
                  ),
                  _ArticleItem(data!)
                ],
              );
            } else {
              return _ArticleItem(data!);
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
        ),
        /* FutureBuilder(
            future: _getArticles(),
            builder: (BuildContext context,
                AsyncSnapshot<List<DatasBean>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ;
              } else {
                return const CircularProgressIndicator();
              }
            }),*/
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
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
class _ArticleItem extends StatelessWidget {
  const _ArticleItem(this._bean);

  final DatasBean _bean;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Text(
                    _bean.niceShareDate,
                    style: const TextStyle(fontSize: 12, color: Colors.black38),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                _bean.title,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    _bean.chapterName,
                    style: const TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Icon(
                    Icons.heart_broken,
                    color: Colors.red,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailArticleRoute(url: _bean.link, title: _bean.title)));
      },
    );
  }
}
