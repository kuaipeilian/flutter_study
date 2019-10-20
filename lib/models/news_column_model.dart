import 'package:json_annotation/json_annotation.dart';

part 'news_column_model.g.dart';

List<NewsColumnModel> getNewsColumnModelList(List<dynamic> list) {
  List<NewsColumnModel> result = [];
  list.forEach((item) {
    result.add(NewsColumnModel.fromJson(item));
  });
  return result;
}

List<ArticleList> getArticleModelList(List<dynamic> list) {
  List<ArticleList> result = [];
  list.forEach((item) {
    result.add(ArticleList.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class NewsColumnModel extends Object {
  @JsonKey(name: 'articleList')
  List<ArticleList> articleList;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'title')
  String title;

  NewsColumnModel(
    this.articleList,
    this.type,
    this.title,
  );

  factory NewsColumnModel.fromJson(Map<String, dynamic> srcJson) =>
      _$NewsColumnModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsColumnModelToJson(this);
}

@JsonSerializable()
class ArticleList extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'keywords')
  String keywords;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'kinds')
  int kinds;

  @JsonKey(name: 'descriptions')
  String descriptions;

  ArticleList(
    this.id,
    this.title,
    this.cover,
    this.keywords,
    this.updatedAt,
    this.kinds,
    this.descriptions,
  );

  factory ArticleList.fromJson(Map<String, dynamic> srcJson) =>
      _$ArticleListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticleListToJson(this);
}
