
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_kpl_vip/models/problem_model.dart';

Future<List<ProblemModel>> generateProblems() async {
  var temp = await rootBundle.loadString('assets/data/problems.json');
  return getProblemModelList(json.decode(temp));
}