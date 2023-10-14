import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Back4AppCustomDio {
  final _dio = Dio();

  Dio get dio => _dio;

  Back4AppCustomDio() {

    
    _dio.options.baseUrl = dotenv.get("BACK4APPBASEURL");
  }
}
