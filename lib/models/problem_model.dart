import 'package:json_annotation/json_annotation.dart'; 
  
part 'problem_model.g.dart';


List<ProblemModel> getProblemModelList(List<dynamic> list){
    List<ProblemModel> result = [];
    list.forEach((item){
      result.add(ProblemModel.fromJson(item));
    });
    return result;
  }
@JsonSerializable()
  class ProblemModel extends Object {

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'options')
  List<String> options;

  @JsonKey(defaultValue: -1)
  int selectOption;

  ProblemModel(this.title,this.options,this.selectOption);

  factory ProblemModel.fromJson(Map<String, dynamic> srcJson) => _$ProblemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProblemModelToJson(this);

}