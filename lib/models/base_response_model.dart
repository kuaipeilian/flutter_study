import 'package:json_annotation/json_annotation.dart'; 
  
part 'base_response_model.g.dart';

@JsonSerializable()
class BaseResponseModel extends Object {
  @JsonKey(defaultValue: -1)
  int code;
  @JsonKey(defaultValue: false)
  bool ret;
  String msg;
  String resultMsg;
  @JsonKey(defaultValue: '')
  var data;
  @JsonKey(defaultValue: '')
  var content;
  bool get status {
    return code == 0 || ret;
  }
  
  BaseResponseModel({this.code,this.msg,this.data, this.content});
  factory BaseResponseModel.fromJson(Map<String, dynamic> srcJson) => _$BaseResponseModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$BaseResponseModelToJson(this);
}