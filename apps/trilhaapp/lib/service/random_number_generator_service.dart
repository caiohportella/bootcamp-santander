import 'dart:math';

class RandomNumberGeneratorService {
  static int generateRandomNumber(int maxNumber) {
    Random generatedNumber = Random();

    return generatedNumber.nextInt(maxNumber);
  }
}