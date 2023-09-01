import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardState();
}

class _CardState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Card(
            elevation: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Image.network(
                          "https://avatars.githubusercontent.com/u/60005589?v=4",
                          width: 50,
                          height: 50,
                        ),
                        const Text("Meu card", style: TextStyle(fontSize: 20)),
                      ],
                    )),
              ],
              const Text("dpgunzhdgpidpgunzhdgpiozegnypguyndpgunzhdgpiozegnypguyndpgunzhdgpiozegnypguyndpgunzhdgpiozegnypguyndpgunzhdgpiozegnypguyndpgunzhdgpiozegnypguynozegnypguyn")
            ),
          ),
        ),
      ],
    );
  }
}
