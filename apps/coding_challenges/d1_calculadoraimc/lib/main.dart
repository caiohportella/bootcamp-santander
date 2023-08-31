import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'calculate_imc.dart';

void main() {
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
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  IMCCalculator imcCalculator = IMCCalculator();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora IMC'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
              keyboardType: TextInputType.name,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
              ],
            ),
            TextField(
              controller: _heightController,
              decoration: const InputDecoration(
                labelText: 'Altura (cm)',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  imcCalculator.returnIMCPerson(
                    double.parse(_heightController.text), 
                    double.parse(_weightController.text),
                  );
                });
              },
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 16.0),
            Visibility(
              visible: 
                _nameController.text.isNotEmpty && 
                _heightController.text.isNotEmpty && 
                _weightController.text.isNotEmpty,
              child: Text(
                '${_nameController.text}, seu IMC é ${imcCalculator.person.bmi}',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}