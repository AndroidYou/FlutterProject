import 'package:json_annotation/json_annotation.dart';

part 'Channel.g.dart';

@JsonSerializable()
class Channel {
  List<ChoseListBean> choseList;
  List<UnChoseListBean> unChoseList;

  Channel({required this.choseList, required this.unChoseList});

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelToJson(this);
}

@JsonSerializable()
class UnChoseListBean {
  String channelName;
  String channelNo;

  UnChoseListBean({required this.channelName, required this.channelNo});

  factory UnChoseListBean.fromJson(Map<String, dynamic> json) =>
      _$UnChoseListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UnChoseListBeanToJson(this);
}

@JsonSerializable()
class ChoseListBean {
  String channelName;
  String channelNo;

  ChoseListBean({required this.channelName, required this.channelNo});

  factory ChoseListBean.fromJson(Map<String, dynamic> json) =>
      _$ChoseListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ChoseListBeanToJson(this);
}
