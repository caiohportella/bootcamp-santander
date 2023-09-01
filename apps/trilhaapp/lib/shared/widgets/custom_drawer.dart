import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/register_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

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
                            onTap: () => {}),
                        ListTile(
                          leading: const Icon(Icons.photo_camera_back_rounded),
                          title: const Text('Escolher da galeria'),
                          onTap: () => {},
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
                Text("Your account"),
              ],
            ),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
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
              Navigator.pop(context);
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
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
