import 'dart:convert';
import 'package:trilhaapp/model/viacep_model.dart';
import 'package:http/http.dart' as http;

class ViaCEPRepository {
  Future<ViaCEPModel> fetchCEP(String cep) async {
    final response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
    if (response.statusCode == 200) {
      return ViaCEPModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load CEP');
    }
  }
}