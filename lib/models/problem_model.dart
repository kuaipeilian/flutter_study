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
  List<Options> options;

  @JsonKey(name: 'correct')
  int correct;

  @JsonKey(defaultValue: -1)
  int selectOption;

  bool get isCorrect {
    return correct == selectOption;
  }

  ProblemModel(this.title,this.options,this.correct,this.selectOption);

  factory ProblemModel.fromJson(Map<String, dynamic> srcJson) => _$ProblemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProblemModelToJson(this);

}

  
@JsonSerializable()
  class Options extends Object {

  @JsonKey(name: 'detail', defaultValue: '')
  String detail;

  @JsonKey(name: 'imgStr', defaultValue: '')
  String imgStr;

  Options(this.detail,this.imgStr,);

  factory Options.fromJson(Map<String, dynamic> srcJson) => _$OptionsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OptionsToJson(this);

}

  
