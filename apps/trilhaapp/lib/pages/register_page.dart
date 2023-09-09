import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/home_page.dart';
import 'package:trilhaapp/service/app_storage_service.dart';
import 'package:trilhaapp/service/repositories/experience_years_repository.dart';
import 'package:trilhaapp/service/repositories/level_repository.dart';
import 'package:trilhaapp/service/repositories/languages_repository.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController(text: "");
  var emailController = TextEditingController(text: "");
  var birthDateController = TextEditingController(text: "");
  DateTime? birthDate;
  var levelRepository = LevelRepository();
  var levels = [];
  var selectedLevel = "";
  var languageRepository = LanguageRepository();
  var languages = [];
  var selectedLanguage = <String>[];
  double chosenSalary = 1320;
  String experienceTime = "";
  var experienceYearsRepository = ExperienceYearsRepository();
  var experienceYears = [];

  AppStorageService appStorageService = AppStorageService();
  // final String K_NAME = "name";
  // final String K_EMAIL = "email";
  // final String K_BIRTH_DATE = "birthDate";
  // final String K_SELECTED_LEVEL = "selectedLevel";
  // final String K_SELECTED_LANGUAGE = "selectedLanguage";
  // final String K_EXPERIENCE_TIME = "experienceTime";
  // final String K_CHOSEN_SALARY = "chosenSalary";

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Digite um email válido'
        : null;
  }

  void loadData() async {
    nameController.text = await appStorageService.getRegisterName();
    emailController.text = await appStorageService.getEmail();
    birthDateController.text = await appStorageService.getRegisterBirthDate();
    selectedLevel = await appStorageService.getRegisterSelectedLevel();
    selectedLanguage = await appStorageService.getRegisterSelectedLanguage();
    experienceTime = await appStorageService.getRegisterExperienceTime();
    chosenSalary = await appStorageService.getRegisterChosenSalary();

    setState(() {});
  }

  @override
  void initState() {
    levels = levelRepository.returnLevels();
    languages = languageRepository.returnLanguages();
    experienceYears = experienceYearsRepository.returnExperienceYears();
    experienceTime = experienceYearsRepository.returnFirstExperienceYear();
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Account"),
          leading: BackButton(
            onPressed: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()))
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const TextLabel(text: "Nome"),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome',
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Nome inválido' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'E-mail',
                      ),
                      validator: validateEmail,
                    ),
                  ],
                ),
              ),
              // const TextLabel(text: "E-mail"),
              // const SizedBox(height: 20),
              // TextFormField(
              //   controller: emailController,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'E-mail',
              //   ),
              //   validator: (value) => value!.isEmpty ? 'E-mail inválido' : null,
              // ),
              const TextLabel(text: "Data de nascimento"),
              const SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                controller: birthDateController,
                onTap: () async {
                  var date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1945, 1, 1),
                      lastDate: DateTime.now());
                  if (date != null) {
                    birthDateController.text = date.toString();
                    birthDate = DateTime.parse(birthDateController.text);
                    birthDate = date;
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Data de nascimento',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Data de nascimento inválida' : null,
              ),
              const TextLabel(text: "Nível de experiência"),
              Column(
                children: levels
                    .map((level) => RadioListTile(
                          title: Text(level.toString()),
                          value: level.toString(),
                          selected: selectedLevel == level.toString(),
                          groupValue: selectedLevel,
                          onChanged: (value) {
                            setState(() {
                              selectedLevel = value.toString();
                            });
                          },
                        ))
                    .toList(),
              ),
              const TextLabel(text: "Linguagens preferidas"),
              Column(
                  children: languages
                      .map((language) => CheckboxListTile(
                          title: Text(language.toString()),
                          value: selectedLanguage.contains(language),
                          onChanged: (bool? value) {
                            if (value!) {
                              setState(() {
                                selectedLanguage.add(language);
                              });
                            } else {
                              setState(() {
                                selectedLanguage.remove(language);
                              });
                            }
                          }))
                      .toList()),
              const TextLabel(text: "Tempo de experiência"),
              DropdownButtonFormField(
                  isExpanded: true,
                  value: experienceTime == ""
                      ? experienceYearsRepository.returnFirstExperienceYear()
                      : experienceTime,
                  items: experienceYears
                      .map((experienceYear) => DropdownMenuItem(
                            value: experienceYear,
                            child: Text(experienceYear.toString()),
                          ))
                      .toList(),
                  onChanged: (selectedExperienceTime) {
                    setState(() {
                      experienceTime = selectedExperienceTime.toString();
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => (value as String?)?.isEmpty ?? true
                      ? 'Tempo de experiência inválido'
                      : null),
              TextLabel(
                  text:
                      "Pretenção salarial: R\$${chosenSalary.round().toString()}"),
              Slider(
                value: chosenSalary,
                min: 1320,
                max: 10000,
                divisions: 500,
                label: "R\$${chosenSalary.round()}",
                onChanged: (double value) {
                  setState(() {
                    chosenSalary = value;
                  });
                },
              ),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await appStorageService
                        .setRegisterName(nameController.text);
                    await appStorageService
                        .setEmail(emailController.toString());
                    await appStorageService.setRegisterBirthDate(birthDate!);
                    await appStorageService
                        .setRegisterExperienceTime(selectedLevel);
                    await appStorageService
                        .setRegisterSelectedLanguage(selectedLanguage);
                    await appStorageService
                        .setRegisterExperienceTime(experienceTime);
                    await appStorageService
                        .setRegisterChosenSalary(chosenSalary);

                    debugPrint("Nome: ${nameController.text};\n"
                        "E-mail: ${emailController.text};\n"
                        "Data de nascimento: ${birthDate?.day}/${birthDate?.month}/${birthDate?.year};\n"
                        "Nível de experiência: ${selectedLevel.toString()};\n"
                        "Linguagens preferidas: ${selectedLanguage.toString()};\n"
                        "Tempo de experiência: ${experienceTime.toString()};\n"
                        "Pretenção salarial: R\$${chosenSalary.round().toString()};\n");

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  } else {
                    debugPrint("Formulário inválido");
                  }
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
