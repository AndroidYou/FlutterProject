// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MainBanner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainBanner _$MainBannerFromJson(Map<String, dynamic> json) => MainBanner(
      data: (json['data'] as List<dynamic>)
          .map((e) => BannerBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['errorCode'] as num,
      errorMsg: json['errorMsg'] as String,
    );

Map<String, dynamic> _$MainBannerToJson(MainBanner instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

BannerBean _$BannerBeanFromJson(Map<String, dynamic> json) => BannerBean(
      desc: json['desc'] as String,
      id: json['id'] as num,
      imagePath: json['imagePath'] as String,
      isVisible: json['isVisible'] as num,
      order: json['order'] as num,
      title: json['title'] as String,
      type: json['type'] as num,
      url: json['url'] as String,
    );

Map<String, dynamic> _$BannerBeanToJson(BannerBean instance) =>
    <String, dynamic>{
      'desc': instance.desc,
      'id': instance.id,
      'imagePath': instance.imagePath,
      'isVisible': instance.isVisible,
      'order': instance.order,
      'title': instance.title,
      'type': instance.type,
      'url': instance.url,
    };
