import 'package:flutter/material.dart';
import 'package:trilhaapp/service/app_storage_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppStorageService storage = AppStorageService();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? username;
  String? email;
  bool isDarkMode = false;
  bool hasPushNotificationOn = false;

  loadData() async {
    usernameController.text = await storage.getSettingsUsername();
    emailController.text = await storage.getEmail();
    isDarkMode = await storage.getSettingsDarkMode();
    hasPushNotificationOn = await storage.getSettingsPushNotification();

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
          appBar: AppBar(title: const Text("Configurações")),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                          labelText: "Nome de usuário",
                          hintText: "Mude seu nome de usuário"),
                      validator: (value) => value!.isEmpty
                          ? "Nome de usuário não pode ser vazio"
                          : null,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                          labelText: "Email", hintText: "Mude seu email"),
                    ),
                  ],
                ),
              ),
              SwitchListTile(
                  title: const Text("Notifications"),
                  value: hasPushNotificationOn,
                  onChanged: (value) => setState(() {
                        hasPushNotificationOn = value;
                      })),
              SwitchListTile(
                title: const Text("Dark mode"),
                value: isDarkMode,
                onChanged: (value) => setState(() {
                  isDarkMode = value;
                }),
              ),
              FloatingActionButton(
                  onPressed: () async {
                    try {
                      await storage.setEmail(emailController.text);
                      await storage
                          .setSettingsUsername(usernameController.text);
                      await storage.setSettingsDarkMode(isDarkMode);
                      await storage
                          .setSettingsPushNotification(hasPushNotificationOn);
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Erro"),
                          content: const Text("Dado inválido, tente novamente"),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Icon(Icons.check_circle_rounded))
                          ],
                        ),
                      );
                    }
                    Navigator.pop(context);

                    setState(() {
                      username = usernameController.text;
                      email = emailController.text;
                    });
                  },
                  child: const Icon(Icons.save_as_rounded))
            ],
          )),
    );
  }
}
