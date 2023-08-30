import 'package:flutter/material.dart';
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
  var nameController = TextEditingController(text: "");
  var birthDateController = TextEditingController(text: "");
  var levelRepository = LevelRepository();
  var levels = [];
  var selectedLevel = "";
  var languageRepository = LanguageRepository();
  var languages = [];
  var selectedLanguage = <String>[];
  double chosenSalary = 1320;
  int experienceTime = 0;
  var experienceYearsRepository = ExperienceYearsRepository();
  var experienceYears = [];
  DateTime? storedBirthDate;

  @override
  void initState() {
    levels = levelRepository.returnLevels();
    languages = languageRepository.returnLanguages();
    experienceYears = experienceYearsRepository.returnExperienceYears();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Account")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
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
              DropdownButton(
                  isExpanded: true,
                  value: experienceYears.first,
                  items: experienceYears
                      .map((experienceYear) => DropdownMenuItem(
                            value: experienceYear,
                            child: Text(experienceYear.toString()),
                          ))
                      .toList(),
                  onChanged: (selectedExperienceTime) {
                    setState(() {
                      experienceTime = selectedExperienceTime as int;
                    });
                  }),
              TextLabel(text: "Pretenção salarial: R\$${chosenSalary.round().toString()}"),
              Slider(
                value: chosenSalary,
                min: 1320,
                max: 10000,
                divisions: 500,
                label: "R\$ 0,00",
                onChanged: (double value) {
                  setState(() {
                    chosenSalary = value;
                  });
                },
              ),
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
