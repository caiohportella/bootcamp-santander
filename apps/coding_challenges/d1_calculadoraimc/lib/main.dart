import 'package:d1_calculadoraimc/model/person_model.dart';
import 'package:d1_calculadoraimc/service/repositories/person_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'calculate_IMC.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(PersonModelAdapter());

  runApp(MaterialApp(
    title: 'Calculadora IMC',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    home: const _CalculateIMC(),
  ));
}

class _CalculateIMC extends StatefulWidget {
  const _CalculateIMC({Key? key}) : super(key: key);

  @override
  _CalculateIMCState createState() => _CalculateIMCState();
}

class _CalculateIMCState extends State<_CalculateIMC> {
  late PersonRepository personRepository;

  var peopleModel = <PersonModel>[];
  var hasGoodBMI = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  // IMCCalculator imcCalculator = IMCCalculator();

  bool isValidPerson(
      TextEditingController nameController,
      TextEditingController heightController,
      TextEditingController weightController) {
    if (nameController.text.isNotEmpty &&
        nameController.text.length > 3 &&
        double.parse(heightController.text) > 145 &&
        double.parse(heightController.text) < 230 &&
        double.parse(weightController.text) > 30 &&
        double.parse(weightController.text) < 300) {
      return true;
    } else {
      return false;
    }
  }

  void getPerson() async {
    personRepository = await PersonRepository.load();
    peopleModel = personRepository.getData(hasGoodBMI);

    setState(() {});
  }

  Widget _getChild() {
    if (peopleModel.isEmpty) {
      return const Center(
        child: Text(
          "Nenhuma pessoa cadastrada",
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: peopleModel.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(peopleModel[index].personID.toString()),
              onDismissed: (DismissDirection direction) async {
                await personRepository.delete(peopleModel[index]);
                getPerson();
              },
              child: ListTile(
                isThreeLine: true,
                title: Text(
                  peopleModel[index].personName.toString().trim(),
                  style: const TextStyle(fontSize: 24),
                ),
                subtitle: Text(
                  "IMC: ${peopleModel[index].personBMI.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 16),
                ),
                trailing: Icon(
                  IMCCalculator().hasGoodBMI(peopleModel[index].personBMI) ==
                          true
                      ? Icons.sentiment_very_satisfied_rounded
                      : Icons.sentiment_very_dissatisfied_rounded,
                  color: IMCCalculator()
                              .hasGoodBMI(peopleModel[index].personBMI) ==
                          true
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            );
          });
    }
  }

  @override
  void initState() {
    getPerson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora IMC'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _nameController.clear();
            _heightController.clear();
            _weightController.clear();
            showDialog(
              context: context,
              builder: (BuildContext bc) => AlertDialog(
                title: const Text("Enviar informações"),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um nome';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _heightController,
                        decoration: const InputDecoration(
                          labelText: 'Altura (cm)',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira uma altura';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _weightController,
                        decoration: const InputDecoration(
                          labelText: 'Peso (kg)',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um peso';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.cancel_rounded),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if ((isValidPerson(_nameController, _heightController,
                                  _weightController) ==
                              true) &&
                          _formKey.currentState!.validate()) {
                        await personRepository.save(PersonModel.create(
                          _nameController.text,
                          double.parse(_heightController.text),
                          double.parse(_weightController.text),
                          IMCCalculator()
                              .returnIMCPerson(
                                  double.parse(_heightController.text),
                                  double.parse(_weightController.text))
                              .personBMI
                              .toDouble(),
                        ));
                        // personRepository.insertData(PersonModel(
                        //     personID: 0,
                        //     personName: _nameController.text,
                        //     personHeight: double.parse(_heightController.text),
                        //     personWeight: double.parse(_weightController.text),
                        //     personBMI: imcCalculator
                        //         .returnIMCPerson(
                        //             double.parse(_heightController.text),
                        //             double.parse(_weightController.text))
                        //         .bmi
                        //         .toDouble(),
                        //     personHasGoodBMI: imcCalculator.hasGoodBMI(
                        //         imcCalculator
                        //             .returnIMCPerson(
                        //                 double.parse(_heightController.text),
                        //                 double.parse(_weightController.text))
                        //             .bmi
                        //             .toDouble())));
                        // await crud.addPerson(Person(
                        //     personName: _nameController.text,
                        //     personHeight: double.parse(_heightController.text),
                        //     personWeight: double.parse(_weightController.text),
                        //     personBMI: imcCalculator
                        //         .returnIMCPerson(
                        //             double.parse(_heightController.text),
                        //             double.parse(_weightController.text))
                        //         .bmi
                        //         .toDouble()));
                        setState(() {
                          getPerson();
                        });
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Preencha todos os campos corretamente"),
                          ),
                        );
                      }
                      setState(() {
                        getPerson();
                      });
                    },
                    child: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            );
          },
          child: const Icon(Icons.add_rounded),
        ),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(children: [
              Expanded(child: _getChild()),
            ])));
  }
}
