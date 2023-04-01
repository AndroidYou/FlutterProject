// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Channel _$ChannelFromJson(Map<String, dynamic> json) => Channel(
      choseList: (json['choseList'] as List<dynamic>)
          .map((e) => ChoseListBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      unChoseList: (json['unChoseList'] as List<dynamic>)
          .map((e) => UnChoseListBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChannelToJson(Channel instance) => <String, dynamic>{
      'choseList': instance.choseList,
      'unChoseList': instance.unChoseList,
    };

UnChoseListBean _$UnChoseListBeanFromJson(Map<String, dynamic> json) =>
    UnChoseListBean(
      channelName: json['channelName'] as String,
      channelNo: json['channelNo'] as String,
    );

Map<String, dynamic> _$UnChoseListBeanToJson(UnChoseListBean instance) =>
    <String, dynamic>{
      'channelName': instance.channelName,
      'channelNo': instance.channelNo,
    };

ChoseListBean _$ChoseListBeanFromJson(Map<String, dynamic> json) =>
    ChoseListBean(
      channelName: json['channelName'] as String,
      channelNo: json['channelNo'] as String,
    );

Map<String, dynamic> _$ChoseListBeanToJson(ChoseListBean instance) =>
    <String, dynamic>{
      'channelName': instance.channelName,
      'channelNo': instance.channelNo,
    };
