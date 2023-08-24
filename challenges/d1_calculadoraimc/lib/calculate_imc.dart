import 'models/person.dart';

class IMCCalculator {
  Person person = Person(weight: 0, height: 0, bmi: 0);

  static double calculate(Person person) {
    double heightInMeters = person.height / 100.0;
    return person.weight / (heightInMeters * heightInMeters);
  }

  Person returnIMCPerson(double height, double weight) {
    person.height = height;
    person.weight = weight;
    person.bmi = calculate(person);
    person.bmi = double.parse(person.bmi!.toStringAsFixed(2));
    return person;
  }
}
