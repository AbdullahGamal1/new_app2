import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://newsapi.org/', receiveDataWhenStatusError: true));
  }

  static Future<Response> getData(
      {required String url, required Map<String, dynamic> query}) async {
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
}
//https://newsapi.org/v2/everything?q=s&apiKey=4ba02a56473e4228a7a8748f2a12303f
