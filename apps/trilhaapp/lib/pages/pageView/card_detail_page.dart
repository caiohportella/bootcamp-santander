import 'package:flutter/material.dart';
import 'package:trilhaapp/model/card_detail.dart';

class CardDetailPage extends StatelessWidget {
  final CardDetail cardDetail;
  const CardDetailPage({Key? key, required this.cardDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: cardDetail.id,
      child: SafeArea(
        child: Scaffold(
          //appBar: AppBar(title: const Text("Detalhe do card")),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: () { Navigator.pop(context);  }, icon: const Icon(Icons.close_rounded)),
                Row(
                  children: [
                    Image.network(
                      cardDetail.image,
                      height: 100,
                    ),
                  ],
                ),
                Text(cardDetail.title, style: const TextStyle(fontSize: 26)),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(cardDetail.content,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
