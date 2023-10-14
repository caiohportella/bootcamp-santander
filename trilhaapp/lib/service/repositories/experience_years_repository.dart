class ExperienceYearsRepository {
  List<String> returnExperienceYears() {
    return [
      "Menos de 1 ano",
      "Entre 1 e 3 anos",
      "Entre 3 e 5 anos",
      "Mais de 5 anos"
    ];
  }

  String returnFirstExperienceYear() {
    return returnExperienceYears().first;
  }
}
