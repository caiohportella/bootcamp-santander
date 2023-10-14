import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'cep_model.dart';
import 'cep_repository.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastra CEP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Cadastra CEP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Dio dio = Dio();
  final _cepController = TextEditingController(text: "");
  final List<Results> _cepList = [];
  bool loading = false;
  CEPModel cep = CEPModel();
  CEPRepository cepRepository = CEPRepository();
  Results cepResults = Results();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            _cepController.text = "";
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: const Text("Adicionar CEP"),
                    content: TextField(
                      controller: _cepController,
                      maxLength: 8,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Digite o CEP",
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancelar")),
                      TextButton(
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            cep = await cepRepository.fetchViaCEP(
                                cep: _cepController.text);
                            setState(() {
                              loading = false;
                            });
                            if (context.mounted) Navigator.of(context).pop();
                          },
                          child: const Text("Adicionar")),
                    ],
                  );
                });
          },
          child: const Icon(Icons.search),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _cepList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Card(
                        child: ListTile(
                          title: Text(_cepList[index].cep!),
                          subtitle: Text(_cepList[index].street!),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await cepRepository
                                  .deleteCEP(_cepList[index].objectId!);
                              setState(() {
                                _cepList.removeAt(index);
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (loading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ));
  }
}