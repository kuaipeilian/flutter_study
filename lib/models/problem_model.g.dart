// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProblemModel _$ProblemModelFromJson(Map<String, dynamic> json) {
  return ProblemModel(
    json['title'] as String,
    (json['options'] as List)
        ?.map((e) =>
            e == null ? null : Options.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['correct'] as int,
    json['selectOption'] as int ?? -1,
  );
}

Map<String, dynamic> _$ProblemModelToJson(ProblemModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'options': instance.options,
      'correct': instance.correct,
      'selectOption': instance.selectOption,
    };

Options _$OptionsFromJson(Map<String, dynamic> json) {
  return Options(
    json['detail'] as String ?? '',
    json['imgStr'] as String ?? '',
  );
}

Map<String, dynamic> _$OptionsToJson(Options instance) => <String, dynamic>{
      'detail': instance.detail,
      'imgStr': instance.imgStr,
    };
