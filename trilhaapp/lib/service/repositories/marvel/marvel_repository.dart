import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trilhaapp/model/characters_model.dart';

class MarvelRepository {
  Future<CharactersModel> fetchCharacters(int offset) async {
    var dio = Dio();
    var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    var publicKey = dotenv.get("MARVELPUBLICKEY");
    var privateKey = dotenv.get("MARVELAPIKEY");
    var hash = _generateMD5(timestamp + privateKey + publicKey);
    var query = "offset=$offset&ts=$timestamp&apikey=$publicKey&hash=$hash";
    var res =
        await dio.get("http://gateway.marvel.com/v1/public/characters?$query");
    var charactersModel = CharactersModel.fromJson(res.data);
    return charactersModel;
  }

  String _generateMD5(String input) {
    final List<int> encodedIntList = utf8.encode(input);
    final Digest digest = md5.convert(encodedIntList);
    final String returnValue = digest.toString();
    return returnValue;
  }
}
