import 'package:json_annotation/json_annotation.dart';

part 'MainKnowledge.g.dart';

@JsonSerializable()
class MainKnowledge {
  List<DataBean> data;
  num errorCode;
  String errorMsg;

  MainKnowledge({required this.data, required this.errorCode, required this.errorMsg});

  factory MainKnowledge.fromJson(Map<String, dynamic> json) => _$MainKnowledgeFromJson(json);

  Map<String, dynamic> toJson() => _$MainKnowledgeToJson(this);
}

@JsonSerializable()
class DataBean {
  dynamic articleList;
  String author;
  List<ChildrenBean> children;
  num courseId;
  String cover;
  String desc;
  num id;
  String lisense;
  String lisenseLink;
  String name;
  num order;
  num parentChapterId;
  num type;
  bool userControlSetTop;
  num visible;

  DataBean({this.articleList, required this.author, required this.children, required this.courseId, required this.cover, required this.desc, required this.id, required this.lisense, required this.lisenseLink, required this.name, required this.order, required this.parentChapterId, required this.type, required this.userControlSetTop, required this.visible});

  factory DataBean.fromJson(Map<String, dynamic> json) => _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
}

@JsonSerializable()
class ChildrenBean {
  dynamic articleList;
  String author;
  dynamic children;
  num courseId;
  String cover;
  String desc;
  num id;
  String lisense;
  String lisenseLink;
  String name;
  num order;
  num parentChapterId;
  num type;
  bool userControlSetTop;
  num visible;

  ChildrenBean({this.articleList, required this.author, this.children, required this.courseId, required this.cover, required this.desc, required this.id, required this.lisense, required this.lisenseLink, required this.name, required this.order, required this.parentChapterId,required this.type,required this.userControlSetTop,required this.visible});

  factory ChildrenBean.fromJson(Map<String, dynamic> json) => _$ChildrenBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ChildrenBeanToJson(this);
}

