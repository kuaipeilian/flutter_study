// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_column_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsColumnModel _$NewsColumnModelFromJson(Map<String, dynamic> json) {
  return NewsColumnModel(
    (json['articleList'] as List)
        ?.map((e) =>
            e == null ? null : ArticleList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['type'] as int,
    json['title'] as String,
  );
}

Map<String, dynamic> _$NewsColumnModelToJson(NewsColumnModel instance) =>
    <String, dynamic>{
      'articleList': instance.articleList,
      'type': instance.type,
      'title': instance.title,
    };

ArticleList _$ArticleListFromJson(Map<String, dynamic> json) {
  return ArticleList(
    json['id'] as int,
    json['title'] as String,
    json['cover'] as String,
    json['keywords'] as String,
    json['updatedAt'] as String,
    json['kinds'] as int,
    json['descriptions'] as String,
  );
}

Map<String, dynamic> _$ArticleListToJson(ArticleList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'cover': instance.cover,
      'keywords': instance.keywords,
      'updatedAt': instance.updatedAt,
      'kinds': instance.kinds,
      'descriptions': instance.descriptions,
    };
