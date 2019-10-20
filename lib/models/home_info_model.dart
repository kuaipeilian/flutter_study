import 'package:json_annotation/json_annotation.dart'; 
  
part 'home_info_model.g.dart';

List<About_us> getAboutUsModelList(List<dynamic> list) {
  List<About_us> result = [];
  list.forEach((item) {
    result.add(About_us.fromJson(item));
  });
  return result;
}

@JsonSerializable()
  class HomeInfoModel extends Object {

  @JsonKey(name: 'about_us')
  List<About_us> aboutUs;

  @JsonKey(name: 'top_banners')
  List<Top_banners> topBanners;

  HomeInfoModel(this.aboutUs,this.topBanners,);

  factory HomeInfoModel.fromJson(Map<String, dynamic> srcJson) => _$HomeInfoModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeInfoModelToJson(this);

}

  
@JsonSerializable()
  class About_us extends Object {

  @JsonKey(name: 'action_type')
  int actionType;

  @JsonKey(name: 'block')
  int block;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'link')
  String link;

  @JsonKey(name: 'publish')
  String publish;

  @JsonKey(name: 'scores')
  String scores;

  @JsonKey(name: 'sub_title')
  String subTitle;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'type')
  int type;

  About_us(this.actionType,this.block,this.cover,this.id,this.link,this.publish,this.scores,this.subTitle,this.title,this.type,);

  factory About_us.fromJson(Map<String, dynamic> srcJson) => _$About_usFromJson(srcJson);

  Map<String, dynamic> toJson() => _$About_usToJson(this);

}

  
@JsonSerializable()
  class Top_banners extends Object {

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'url_has_video')
  int urlHasVideo;

  Top_banners(this.cover,this.name,this.url,this.urlHasVideo,);

  factory Top_banners.fromJson(Map<String, dynamic> srcJson) => _$Top_bannersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Top_bannersToJson(this);

}

  
