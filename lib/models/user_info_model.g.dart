// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) {
  return UserInfoModel(
    mobile: json['mobile'] as String,
    token: json['token'] as String,
    studentId: json['studentId'] as String,
    accountId: json['accountId'] as String,
    newAccount: json['newAccount'] as int,
    status: json['status'] as int,
  );
}

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'token': instance.token,
      'studentId': instance.studentId,
      'accountId': instance.accountId,
      'newAccount': instance.newAccount,
      'status': instance.status,
    };
