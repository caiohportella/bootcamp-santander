import 'package:flutter/material.dart';
import 'package:trilhaapp/model/viacep_model.dart';
import 'package:trilhaapp/service/repositories/http/viacep_repository.dart';

class SearchZipCodePage extends StatefulWidget {
  const SearchZipCodePage({Key? key}) : super(key: key);

  @override
  State<SearchZipCodePage> createState() => _SearchZipCodePageState();
}

class _SearchZipCodePageState extends State<SearchZipCodePage> {
  var zipController = TextEditingController(text: "");
  bool loading = false;
  var viacep = ViaCEPModel();
  var viaCEPRepository = ViaCEPRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Buscar CEP"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: "Digite o CEP",
                ),
                controller: zipController,
                maxLength: 8,
                keyboardType: TextInputType.number,
                onChanged: (value) async {
                  var zip = value.replaceAll(RegExp(r'[^0-9]'), '');
                  if (zip.length == 8) {
                    setState(() {
                      loading = true;
                    });
                    viacep = await viaCEPRepository.fetchCEP(zip);                   
                  }
                },
              ),
              const SizedBox(height: 50),
              Text(
                "Endereço: ${viacep.logradouro} - ${viacep.bairro}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 50),
              Text(
                "${viacep.localidade} - ${viacep.uf}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),
              if (loading) const CircularProgressIndicator(),
              // ElevatedButton(
              //   onPressed: () async {
              //     var response = await http
              //         .get(Uri.parse("viacep.com.br/ws/01001000/json/"));
              //     debugPrint(response.body);
              //   },
              //   child: const Text("Buscar"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
