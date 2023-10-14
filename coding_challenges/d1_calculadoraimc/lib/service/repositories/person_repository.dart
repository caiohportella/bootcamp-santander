import 'package:hive/hive.dart';
import 'package:d1_calculadoraimc/model/person_model.dart';

class PersonRepository {
  static late Box _personBox;

  PersonRepository._create();

  static Future<PersonRepository> load() async {
    if (Hive.isBoxOpen("box_person")) {
      _personBox = Hive.box("box_person");
    } else {
      _personBox = await Hive.openBox("box_person");
    }

    return PersonRepository._create();
  }

  save(PersonModel person) {
    _personBox.add(person);
  }

  update(PersonModel person) {
    person.save();
  }

  delete(PersonModel person) {
    person.delete();
  }

  List<PersonModel> getData(bool hasGoodBMI) {
    if (hasGoodBMI) {
      return _personBox.values
          .where((element) => element.personHasGoodBMI == true)
          .cast<PersonModel>()
          .toList();
    }

    return _personBox.values.cast<PersonModel>().toList();
  }

  // Future<List<PersonModel>> getData(bool hasGoodBMI) async {
  //   List<PersonModel> people = [];
  //   var db = await SQFLiteDatabase().getDatabase();
  //   var result = await db.rawQuery(
  //       hasGoodBMI
  //           ? 'SELECT * FROM person WHERE isGoodBMI = 0'
  //           : 'SELECT * FROM person',
  //       [hasGoodBMI ? 0 : 1]);
  //   for (var item in result) {
  //     people.add(PersonModel(
  //       personID: int.parse(item['id'].toString()),
  //       personName: item['name'].toString(),
  //       personWeight: double.parse(item['weight'].toString()),
  //       personHeight: double.parse(item['height'].toString()),
  //       personBMI: double.parse(item['bmi'].toString()),
  //       personHasGoodBMI: item['isGoodBMI'] == 1,
  //     ));
  //   }

  //   return people;
  // }

  // Future<void> insertData(PersonModel person) async {
  //   var db = await SQFLiteDatabase().getDatabase();
  //   await db.insert(
  //     'person',
  //     {
  //       'name': person.personName,
  //       'weight': person.personWeight,
  //       'height': person.personHeight,
  //       'bmi': person.personBMI,
  //       'isGoodBMI': person.personHasGoodBMI ? 1 : 0
  //     },
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  // Future<void> updateData(PersonModel person) async {
  //   var db = await SQFLiteDatabase().getDatabase();

  //   await db.update(
  //     'person',
  //     {
  //       'name': person.personName,
  //       'weight': person.personWeight,
  //       'height': person.personHeight,
  //       'bmi': person.personBMI,
  //       'isGoodBMI': person.personHasGoodBMI ? 1 : 0
  //     },
  //     where: 'id = ?',
  //     whereArgs: [person.personID],
  //   );
  // }

  // Future<void> deleteData(PersonModel person) async {
  //   var db = await SQFLiteDatabase().getDatabase();
  //   await db.delete(
  //     'person',
  //     where: 'id = ?',
  //     whereArgs: [person.personID],
  //   );
  // }

  // addPerson(Person person) async {
  //   Person personToAdd = Person();
  //   personToAdd.name = person.name;
  //   personToAdd.weight = person.weight;
  //   personToAdd.height = person.height;
  //   personToAdd.bmi = person.bmi;
  //   personToAdd.isGoodBMI = person.isGoodBMI;

  //   await personToAdd.save();
}
