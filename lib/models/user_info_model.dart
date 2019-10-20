import 'package:json_annotation/json_annotation.dart'; 
  
part 'user_info_model.g.dart';

@JsonSerializable()
  class UserInfoModel extends Object {

  String mobile;

  String token;

  String studentId;

  String accountId;

  int newAccount;
  
  //-1 新注册用户 0新注册用户 1试听用户 2有排课付费用户 3已预约体验课用户 4已排体验课用户 5待排课付费用户 6无剩余课时付费用户 7已预约付费用户'
  int status;


  UserInfoModel({this.mobile, this.token, this.studentId, this.accountId, this.newAccount, this.status});

  factory UserInfoModel.fromJson(Map<String, dynamic> srcJson) => _$UserInfoModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);

}