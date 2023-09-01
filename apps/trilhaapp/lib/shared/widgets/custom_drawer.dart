import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:trilhaapp/pages/login_page.dart';
=======
>>>>>>> c70ee7344e1a465e05b7e5607f308db2d74d9aa3
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
<<<<<<< HEAD
                      borderRadius: BorderRadius.circular(10.0)),
=======
                    borderRadius: BorderRadius.circular(10.0)),
>>>>>>> c70ee7344e1a465e05b7e5607f308db2d74d9aa3
                  builder: (BuildContext bc) {
                    return Wrap(
                      children: <Widget>[
                        ListTile(
<<<<<<< HEAD
                          leading: const Icon(Icons.camera_alt_rounded),
                          title: const Text('Tirar foto'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo_camera_back_rounded),
                          title: const Text('Escolher da galeria'),
                          onTap: () {
                            Navigator.pop(context);
                          },
=======
                            leading: const Icon(Icons.camera_alt_rounded),
                            title: const Text('Tirar foto'),
                            onTap: () => {}),
                        ListTile(
                          leading: const Icon(Icons.photo_camera_back_rounded),
                          title: const Text('Escolher da galeria'),
                          onTap: () => {},
>>>>>>> c70ee7344e1a465e05b7e5607f308db2d74d9aa3
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
<<<<<<< HEAD
                Text("Sua conta"),
=======
                Text("Your account"),
>>>>>>> c70ee7344e1a465e05b7e5607f308db2d74d9aa3
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
<<<<<<< HEAD
=======
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
>>>>>>> c70ee7344e1a465e05b7e5607f308db2d74d9aa3
                Icon(Icons.exit_to_app),
                SizedBox(width: 10),
                Text("Sair"),
              ],
            ),
            onTap: () {
<<<<<<< HEAD
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
=======
              Navigator.pop(context);
>>>>>>> c70ee7344e1a465e05b7e5607f308db2d74d9aa3
            },
          ),
        ],
      ),
    );
  }
}
