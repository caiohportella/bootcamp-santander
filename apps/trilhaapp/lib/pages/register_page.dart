import 'package:flutter/material.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var nameController = TextEditingController(text: "");
  var birthDateController = TextEditingController(text: "");
  DateTime? storedBirthDate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Account")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextLabel(text: "Nome"),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                ),
              ),
              const SizedBox(height: 20),
              const TextLabel(text: "Data de nascimento"),
              const SizedBox(height: 20),
              TextField(
                readOnly: true,
                controller: birthDateController,
                onTap: () async {
                  var birthDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1945, 1, 1),
                      lastDate: DateTime.now());
                  if (birthDate != null) {
                    birthDateController.text =
                        "${birthDate.day}/${birthDate.month}/${birthDate.year}";
                  }
                  storedBirthDate = birthDate;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Data de nascimento',
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => {
                  // Navigator.pop(context, nameController.text),
                  debugPrint(
                      "Nome: ${nameController.text} e Data de nascimento: ${storedBirthDate?.day}/${storedBirthDate?.month}/${storedBirthDate?.year}"),
                },
                child: const Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
