// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeInfoModel _$HomeInfoModelFromJson(Map<String, dynamic> json) {
  return HomeInfoModel(
    (json['about_us'] as List)
        ?.map((e) =>
            e == null ? null : About_us.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['top_banners'] as List)
        ?.map((e) =>
            e == null ? null : Top_banners.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HomeInfoModelToJson(HomeInfoModel instance) =>
    <String, dynamic>{
      'about_us': instance.aboutUs,
      'top_banners': instance.topBanners,
    };

About_us _$About_usFromJson(Map<String, dynamic> json) {
  return About_us(
    json['action_type'] as int,
    json['block'] as int,
    json['cover'] as String,
    json['id'] as int,
    json['link'] as String,
    json['publish'] as String,
    json['scores'] as String,
    json['sub_title'] as String,
    json['title'] as String,
    json['type'] as int,
  );
}

Map<String, dynamic> _$About_usToJson(About_us instance) => <String, dynamic>{
      'action_type': instance.actionType,
      'block': instance.block,
      'cover': instance.cover,
      'id': instance.id,
      'link': instance.link,
      'publish': instance.publish,
      'scores': instance.scores,
      'sub_title': instance.subTitle,
      'title': instance.title,
      'type': instance.type,
    };

Top_banners _$Top_bannersFromJson(Map<String, dynamic> json) {
  return Top_banners(
    json['cover'] as String,
    json['name'] as String,
    json['url'] as String,
    json['url_has_video'] as int,
  );
}

Map<String, dynamic> _$Top_bannersToJson(Top_banners instance) =>
    <String, dynamic>{
      'cover': instance.cover,
      'name': instance.name,
      'url': instance.url,
      'url_has_video': instance.urlHasVideo,
    };
