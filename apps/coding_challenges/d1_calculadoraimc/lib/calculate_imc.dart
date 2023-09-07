import 'package:d1_calculadoraimc/models/person.dart';

class IMCCalculator {
  Person person = Person();

  double calculate(double height, double weight) {
    double heightInMeters = height / 100.0;
    return weight / (heightInMeters * heightInMeters);
  }

  Person returnIMCPerson(double height, double weight) {
    person.height = height;
    person.weight = weight;
    person.bmi = calculate(height, weight);
    person.bmi = double.parse(person.bmi.toStringAsFixed(2));
    return person;
  }

  bool hasGoodBMI(double bmi) {
    if (bmi < 18.5 || bmi >= 40) {
      person.hasGoodBMI = false;
    } else if ((bmi >= 18.5 && bmi < 25) || (bmi >= 30 && bmi < 35)) {
      person.hasGoodBMI = true;
    } else {
      person.hasGoodBMI = false;
    }

    return person.hasGoodBMI;
  }
}
