import 'package:dio/dio.dart';

import 'package:back4appcep/cep_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CEPRepository {
  final dio = Dio();

  CEPRepository();
  
  Future<CEPModel> fetchViaCEP({required String cep}) async {
    try {
      Response res = await dio.get('https://viacep.com.br/ws/$cep/json');
      final data = res.data;
      return CEPModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkBack4AppCEP({required String cepSeeker}) async {
    try {
      Response res = await dio.get(
          "${dotenv.get("BACK4APPBASEURL")}?where={\"cep\":\"$cepSeeker\"}");
      final data = res.data['results'] as List<dynamic>;

      return data.isNotEmpty;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CEPModel>> fetchAllCEPs() async {
    try {
      Response res = await dio.get(dotenv.get("BACK4APPBASEURL"));
      final data = res.data['results'] as List<dynamic>;
      return data.map((e) => CEPModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createCEP(Results cep) async {
    try {
      await dio.post("${dotenv.get("BASEURL")}CEPDB", data: cep.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCEP(Results cep) async {
    try {
      await dio.put("${dotenv.get("BASEURL")}${cep.objectId}",
          data: cep.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCEP(String objID) async {
    try {
      await dio.delete("${dotenv.get("BACK4APPBASEURL")}$objID");
    } catch (e) {
      rethrow;
    }
  }
}
