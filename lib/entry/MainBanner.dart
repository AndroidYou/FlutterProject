import 'package:json_annotation/json_annotation.dart';

part 'MainBanner.g.dart';

@JsonSerializable()
class MainBanner {
  List<BannerBean> data;
  num errorCode;
  String errorMsg;

  MainBanner({required this.data, required this.errorCode, required this.errorMsg});

  factory MainBanner.fromJson(Map<String, dynamic> json) => _$MainBannerFromJson(json);

  Map<String, dynamic> toJson() => _$MainBannerToJson(this);
}

@JsonSerializable()
class BannerBean {
  String desc;
  num id;
  String imagePath;
  num isVisible;
  num order;
  String title;
  num type;
  String url;

  BannerBean({required this.desc, required this.id, required this.imagePath,required this.isVisible,required this.order,required this.title,required this.type,required this.url});

  factory BannerBean.fromJson(Map<String, dynamic> json) => _$BannerBeanFromJson(json);

  Map<String, dynamic> toJson() => _$BannerBeanToJson(this);
}

