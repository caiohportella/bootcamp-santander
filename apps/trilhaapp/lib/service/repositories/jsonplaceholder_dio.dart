import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class JSONPlaceHolder {
  final _dio = Dio();

  Dio get dio => _dio;

  JSONPlaceHolder() {
    var url = dotenv.get('JSONPLACEHOLDER', fallback: 'sane-default');
    _dio.options.baseUrl = url;
  }
}
