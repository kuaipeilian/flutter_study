// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseModel _$BaseResponseModelFromJson(Map<String, dynamic> json) {
  return BaseResponseModel(
    code: json['code'] as int ?? -1,
    msg: json['msg'] as String,
    data: json['data'] ?? '',
    content: json['content'] ?? '',
  )
    ..ret = json['ret'] as bool ?? false
    ..resultMsg = json['resultMsg'] as String;
}

Map<String, dynamic> _$BaseResponseModelToJson(BaseResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'ret': instance.ret,
      'msg': instance.msg,
      'resultMsg': instance.resultMsg,
      'data': instance.data,
      'content': instance.content,
    };
