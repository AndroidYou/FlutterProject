
import 'dart:convert';

import 'package:http/http.dart' as http;
class ApiManager{
  static const String _baseUrl = "https://www.wanandroid.com";



  static const String _mainArticleList = "$_baseUrl/article/list/1/json";
  static const String _mainBanner = "$_baseUrl/banner/json";

  /// 首页列表
  static getMainArticleList() async{
    return await _getData(_mainArticleList);
  }
  ///首页banner
  static getMainBanner() async{
    return await _getData(_mainBanner);
  }



  _postData(Map map,String url) async{
    return await http.post(Uri.parse(url),headers: {"content-type": "application/json"},body: utf8.encode(json.encode(map))).timeout(const Duration(milliseconds: 10000));
  }
  static _getData(String url) async{
    return await http.get(Uri.parse(url)).timeout(const Duration(milliseconds: 10000));
  }
}