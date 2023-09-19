import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/heroes/heroes_page.dart';
import 'package:trilhaapp/pages/login_page.dart';
import 'package:trilhaapp/pages/posts_page.dart';
import 'package:trilhaapp/pages/random_number/random_number_hive_page.dart';
import 'package:trilhaapp/pages/register_data/register_page_hive.dart';
import 'package:trilhaapp/pages/settings/settings_hive_page.dart';
import 'package:trilhaapp/service/image_picker_service.dart';
import 'package:trilhaapp/service/repositories/marvel/marvel_repository.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  ImagePickerService imagePickerService = const ImagePickerService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  builder: (BuildContext bc) {
                    return Wrap(
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.camera_alt_rounded),
                          title: const Text('Tirar foto'),
                          onTap: imagePickerService.getImageFromCamera,
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo_camera_back_rounded),
                          title: const Text('Escolher da galeria'),
                          onTap: imagePickerService.getImageFromGallery,
                        ),
                      ],
                    );
                  });
            },
            child: const UserAccountsDrawerHeader(
              accountName: Text("Caio H. Portella"),
              accountEmail: Text("caio@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/60005589?v=4"),
              ),
            ),
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 10),
                Text("Sua conta"),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterHivePage(),
                  ));
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.numbers_outlined),
                SizedBox(width: 10),
                Text("Gerador de números aleatórios"),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RandomNumberHivePage(),
                  ));
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.settings),
                SizedBox(width: 10),
                Text("Configurações"),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsHivePage(),
                  ));
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.post_add_rounded),
                SizedBox(width: 10),
                Text("Posts"),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PostsPage(),
                  ));
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.api_rounded),
                SizedBox(width: 10),
                Text("Heroes"),
              ],
            ),
            onTap: () async {
              var marvelRepository = MarvelRepository();
              await marvelRepository.fetchCharacters(0);
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HeroesPage(),
                  ));
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.exit_to_app),
                SizedBox(width: 10),
                Text("Sair"),
              ],
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext bc) {
                    return AlertDialog(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      title: const Text("Sair"),
                      content: const Text("Deseja realmente sair?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Não"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: const Text("Sim"),
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
