import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://fcm.googleapis.com/",
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type' : 'application/json',
          'Authorization' : "key=AAAAbMO3jKE:APA91bFnW8UtWELemb32RzEOSS_qTe1PAgoJOtcX1__a0XxQbun3Ttx8ToVvaOMmtM4lhAPhX697j8mLg2KsEV_eIy1bSOrW_x4xBwmzl4-8nZarCp-pzSIYoPviEqBUIHMFFqKI-U5V",
        },
      ),
    );
  }

  static Future<Response> getDate({
    @required String url,
    Map<String, dynamic> query,
    String token,
    String lang = "en",
  }) async {

    dio.options.headers =
    {
      'lang' : lang,
      'Content-Type' : 'application/json',
      'Authorization' : token??"",
    };

    return await dio.get(url, queryParameters: query??null );
  }

  static Future<Response> postData(
      {@required String url,
      Map<String, dynamic> query,
      String token,
      String lang = "en",
      @required Map<String, dynamic> data}) async {

    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData(
      {@required String url,
        Map<String, dynamic> query,
        String token,
        String lang = "en",
        @required Map<String, dynamic> data}) async {

    dio.options.headers =
    {
      'Content-Type' : 'application/json',
      'lang' : lang,
      'Authorization' : token??"",
    };

    return await dio.put(url, queryParameters: query, data: data);
  }

}
