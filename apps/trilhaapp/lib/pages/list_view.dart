import 'package:flutter/material.dart';
import 'package:trilhaapp/shared/widgets/app_images.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _PageThreeState();
}

class _PageThreeState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text("Caio"),
          subtitle: const Row(
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            children: [
              Text("Ensaio da Exorcise hoje?"),
              Text("22:55"),
            ],
          ),
          trailing: PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  child: Text("Editar"),
                ),
                const PopupMenuItem(
                  child: Text("Excluir"),
                ),
              ];
            },
          ),  
          leading: CircleAvatar(backgroundImage: AssetImage(AppImages.user)),
        ),
        Image.asset(AppImages.ffaaBanner),
        Image.asset(AppImages.genocidalBanner),
        Image.asset(AppImages.negationistBanner),
        Image.asset(AppImages.user),
      ],
    );
  }
}
