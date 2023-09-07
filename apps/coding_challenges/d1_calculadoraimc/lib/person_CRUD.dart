import 'package:d1_calculadoraimc/models/person.dart';

class PersonCRUD {
  final List<Person> _persons = [];
  Future<void> addPerson(Person person) async {
    await Future.delayed(const Duration(microseconds: 200));
    _persons.add(person);
  }

  Future<void> removePerson(Person person) async {
    await Future.delayed(const Duration(microseconds: 200));
    _persons.remove(person);
  }

  Future<void> updatePerson(String id, bool isGood) async {
    await Future.delayed(const Duration(microseconds: 200));
    final person = _persons.firstWhere((element) => element.id == id);
    person.hasGoodBMI = isGood;
  }

  Future<List<Person>> listPersons() async {
    await Future.delayed(const Duration(microseconds: 200));

    return _persons;
  }
}
