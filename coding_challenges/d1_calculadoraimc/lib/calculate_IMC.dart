import 'package:d1_calculadoraimc/model/person_model.dart';

class IMCCalculator {
  PersonModel person = PersonModel();

  double calculate(double height, double weight) {
    double heightInMeters = height / 100.0;
    return weight / (heightInMeters * heightInMeters);
  }

  PersonModel returnIMCPerson(double height, double weight) {
    person.personHeight = height;
    person.personWeight = weight;
    person.personBMI = calculate(height, weight);
    person.personBMI = double.parse(person.personBMI.toStringAsFixed(2));
    return person;
  }

  bool hasGoodBMI(double bmi) {
    if (bmi < 18.5 || bmi >= 40) {
      person.personHasGoodBMI = false;
    } else if ((bmi >= 18.5 && bmi < 25) || (bmi >= 30 && bmi < 35)) {
      person.personHasGoodBMI = true;
    } else {
      person.personHasGoodBMI = false;
    }

    return person.personHasGoodBMI;
  }
}
