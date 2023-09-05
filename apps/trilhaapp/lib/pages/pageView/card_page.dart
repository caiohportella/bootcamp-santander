import 'package:flutter/material.dart';
import 'package:trilhaapp/model/card_detail.dart';
import 'package:trilhaapp/pages/pageView/card_detail_page.dart';
import 'package:trilhaapp/service/repositories/card_detail_repository.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardState();
}

class _CardState extends State<CardPage> {
  CardDetail? cardDetail;

  @override
  void initState() {
    CardDetailRepository().get().then((value) {
      setState(() {
        cardDetail = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: cardDetail == null
              ? const LinearProgressIndicator()
              : GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CardDetailPage(cardDetail: cardDetail!),
                      ),
                    );
                  },
                  child: Hero(
                    tag: cardDetail!.id,
                    child: Card(
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    cardDetail!.image,
                                    height: 40,
                                  ),
                                ),
                                Text(cardDetail!.title,
                                    style: const TextStyle(fontSize: 18)),
                              ],
                            ),
                            Text(cardDetail!.content,
                                style: const TextStyle(fontSize: 14),
                                textAlign: TextAlign.center),
                            Container(
                                width: double.infinity,
                                alignment: Alignment.centerRight,
                                child: const TextButton(
                                    onPressed: null, child: Text("Ver mais"))),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
