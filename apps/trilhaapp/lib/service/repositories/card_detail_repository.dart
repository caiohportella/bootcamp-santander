import 'package:trilhaapp/model/card_detail.dart';

class CardDetailRepository {
  Future<CardDetail> get() async {
    await Future.delayed(const Duration(seconds: 2));
    return CardDetail(
      id: 1,
      title: "Meu card",
      content:
          "Eu anim sit aliqua ex nulla elit. Sint ad voluptate enim consectetur nostrud nostrud dolore ad enim pariatur eiusmod ullamco do commodo. Mollit ex deserunt ullamco culpa occaecat elit et et. Mollit excepteur non non fugiat dolor consequat eiusmod eu ipsum nulla labore esse. Lorem ad adipisicing eiusmod Lorem voluptate amet sint officia ullamco aliquip aute proident. Qui ullamco anim amet reprehenderit.",
      image: "https://avatars.githubusercontent.com/u/60005589?v=4",
    );
  }
}
