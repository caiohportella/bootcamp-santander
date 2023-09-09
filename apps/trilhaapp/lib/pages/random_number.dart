import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trilhaapp/service/app_storage_service.dart';

class RandomNumberPage extends StatefulWidget {
  const RandomNumberPage({super.key});

  @override
  State<RandomNumberPage> createState() => _RandomNumberPageState();
}

class _RandomNumberPageState extends State<RandomNumberPage> {
  int generatedNumber = 0;
  int clicks = 0;

  AppStorageService storage = AppStorageService();

  void loadData() async {
    generatedNumber = await storage.getRandomNumberInt();
    clicks = await storage.getClicks();

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
          appBar: AppBar(title: const Text("Gerador de números aleatórios")),
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
              storage.setRandomNumberInt(generatedNumber);
              storage.setClicks(clicks);
            },
            child: const Icon(Icons.add),
          )),
    );
  }
}
