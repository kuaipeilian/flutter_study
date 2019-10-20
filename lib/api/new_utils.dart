import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_kpl_vip/config/application.dart';
import 'package:flutter_kpl_vip/models/base_response_model.dart';

Map<String, dynamic> requestHeader = {
  'content-type': 'application/json',
  // 'Authorization':
  //     'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vdXNlci53ZWlsYWljaGVuZy5jb20vYXBpL3VzZXJzL2xvZ2luIiwiaWF0IjoxNTY1NzY1NDYzLCJuYmYiOjE1NjU3NjU0NjMsImp0aSI6IkdmMEZNTTN0VXJWOER0V1oiLCJzdWIiOiI0Yjg2NDRjMC01NGMzLTExZTgtOTAwNS1hMWM0ZjdjMWJjNDgiLCJwcnYiOiI5YzQyOWU2YTYwY2Q1Mjg1NDczZjJjOGJjNzAxZWMwOTQ4ZGY0ZDhjIn0.DoLcUm3wwztGOkEotk57ks6ddGmpAeWbc4SCKWP030Q'
};

var dio = new Dio(BaseOptions(
  connectTimeout: 30000,
  baseUrl: Application().baseUrl,
  headers: requestHeader,
));

class NetUtils {
  static void setKPLToken(token) {
    dio.options.headers['Authorization'] = token;
  }

  static Future<BaseResponseModel> get(String url,
      [Map<String, dynamic> params]) async {
    var response;
    try {
      if (params != null) {
        response = await dio.get(url, queryParameters: params);
      } else {
        response = await dio.get(url);
      }
      //请求成功（这个200是地址访问成功，不是本地约定好的成功）
      if (response.statusCode == 200) {
        return BaseResponseModel.fromJson(response.data);
      } else {
        return BaseResponseModel(code: 10, msg: 'code: ${response.statusCode}');
      }
    } catch (e) {
      return BaseResponseModel(code: 11, msg: '请求失败');
    }
  }

  static Future<BaseResponseModel> post(String url, Map<String, dynamic> params,
      {ContentType contentType}) async {
    var response;
    try {
      if (params != null) {
        if (contentType != null) {
          response = await dio.post(url,
              data: params, options: Options(contentType:ContentType.parse("application/x-www-form-urlencoded"), headers: {
                'content-type': 'application/x-www-form-urlencoded'
              }));
        } else {
          response = await dio.post(url, data: params);
        }
      } else {
        response = await dio.post(url);
      }
     
      return BaseResponseModel.fromJson(response.data);
    } catch (e) {
      return BaseResponseModel(code: 11, msg: '请求失败');
    }
  }
}
