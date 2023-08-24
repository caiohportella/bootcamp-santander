import 'package:flutter/material.dart';

import 'package:trilhaapp/service/random_number_generator_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int randNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu App')
      ),
      body: Center(
        child: Text(randNumber.toString())
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            randNumber = RandomNumberGeneratorService.generateRandomNumber(1000);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
