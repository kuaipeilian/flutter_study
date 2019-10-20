// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProblemModel _$ProblemModelFromJson(Map<String, dynamic> json) {
  return ProblemModel(
    json['title'] as String,
    (json['options'] as List)?.map((e) => e as String)?.toList(),
    json['selectOption'] as int ?? -1,
  );
}

Map<String, dynamic> _$ProblemModelToJson(ProblemModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'options': instance.options,
      'selectOption': instance.selectOption,
    };
