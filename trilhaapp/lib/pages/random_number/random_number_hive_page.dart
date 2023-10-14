import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RandomNumberHivePage extends StatefulWidget {
  const RandomNumberHivePage({super.key});

  @override
  State<RandomNumberHivePage> createState() => _RandomNumberHivePageState();
}

class _RandomNumberHivePageState extends State<RandomNumberHivePage> {
  int generatedNumber = 0;
  int clicks = 0;

  late Box randomNumbersBox;

  void loadData() async {
    if(Hive.isBoxOpen("box_random_numbers")) {
      randomNumbersBox = Hive.box("box_random_numbers");
    } else {
      randomNumbersBox = await Hive.openBox("box_random_number");
    }
    generatedNumber = randomNumbersBox.get("generatedNumber") ?? 0;
    clicks = randomNumbersBox.get("clicks") ?? 0;

    setState(() {});
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: const Text("Gerador de números aleatórios Hive")),
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Número gerado: $generatedNumber",
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                Text("Número de cliques: $clicks",
                    style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var random = Random();

              setState(() {
                generatedNumber = random.nextInt(1000);
                clicks = clicks + 1;
              });
              randomNumbersBox.put("generatedNumber", generatedNumber);
              randomNumbersBox.put("clicks", clicks);
            },
            child: const Icon(Icons.add),
          )),
    );
  }
}
