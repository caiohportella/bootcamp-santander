import 'package:flutter/material.dart';
import 'package:trilhaapp/model/settings_model.dart';
import 'package:trilhaapp/service/repositories/settings_repository.dart';

class SettingsHivePage extends StatefulWidget {
  const SettingsHivePage({super.key});

  @override
  State<SettingsHivePage> createState() => _SettingsHivePageState();
}

class _SettingsHivePageState extends State<SettingsHivePage> {
  late SettingsRepository settingsRepository;
  var settings = SettingsModel.empty();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  loadData() async {
    settingsRepository = await SettingsRepository.load();
    settings = settingsRepository.getData();
    usernameController.text = settings.username;
    emailController.text = settings.email;

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
          appBar: AppBar(title: const Text("Configurações Hive")),
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
                  value: settings.getNotifications,
                  onChanged: (value) => setState(() {
                        settings.getNotifications = value;
                      })),
              SwitchListTile(
                title: const Text("Dark mode"),
                value: settings.isDarkMode,
                onChanged: (value) => setState(() {
                  settings.isDarkMode = value;
                }),
              ),
              FloatingActionButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    try {
                      settings.settingsEmail = emailController.text;
                      settings.settingsUsername = usernameController.text;
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
                    settingsRepository.save(settings);
                    Navigator.pop(context);

                    setState(() {
                      settings.username = usernameController.text;
                      settings.email = emailController.text;
                    });
                  },
                  child: const Icon(Icons.save_as_rounded))
            ],
          )),
    );
  }
}
