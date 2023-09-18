import 'package:dio/dio.dart';

class JSONPlaceHolder {
  final _dio = Dio();

  Dio get dio => _dio;

  JSONPlaceHolder() {
    _dio.options.baseUrl = 'https://jsonplaceholder.typicode.com';
  }
}
