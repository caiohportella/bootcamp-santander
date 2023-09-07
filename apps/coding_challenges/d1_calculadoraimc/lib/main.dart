import 'package:d1_calculadoraimc/models/person.dart';
import 'package:d1_calculadoraimc/person_CRUD.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'calculate_IMC.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  var crud = PersonCRUD();
  var people = <Person>[];

  IMCCalculator imcCalculator = IMCCalculator();
  Person person = Person();

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

  void getPeople() async {
    people = await crud.listPersons();
    setState(() {});
  }

  Widget _getChild() {
    if (people.isEmpty) {
      return const Center(
        child: Text(
          "Nenhuma pessoa cadastrada",
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: people.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(people[index].id.toString()),
              onDismissed: (DismissDirection direction) async {
                await crud.removePerson(people[index]);
                getPeople();
              },
              child: ListTile(
                isThreeLine: true,
                title: Text(
                  people[index].name.trim(),
                  style: const TextStyle(fontSize: 24),
                ),
                subtitle: Text(
                  "IMC: ${people[index].bmi}",
                  style: const TextStyle(fontSize: 16),
                ),
                trailing: Icon(
                  IMCCalculator().hasGoodBMI(people[index].bmi) == true
                      ? Icons.sentiment_very_satisfied_rounded
                      : Icons.sentiment_very_dissatisfied_rounded,
                  color: IMCCalculator().hasGoodBMI(people[index].bmi) == true
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
    getPeople();
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
                        await crud.addPerson(Person(
                            personName: _nameController.text,
                            personHeight: double.parse(_heightController.text),
                            personWeight: double.parse(_weightController.text),
                            personBMI: imcCalculator
                                .returnIMCPerson(
                                    double.parse(_heightController.text),
                                    double.parse(_weightController.text))
                                .bmi
                                .toDouble()));
                        setState(() {
                          getPeople();
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
                        getPeople();
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
