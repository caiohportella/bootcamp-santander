import 'package:hive/hive.dart';
part 'user_data_model.g.dart';

@HiveType(typeId: 0)
class UserDataModel extends HiveObject {
  @HiveField(0)
  String? userDataUsername;

  @HiveField(1)
  String? userDataEmail;

  DateTime? userDataDateOfBirth;

  @HiveField(2)
  String? userDataExperienceLevel;

  @HiveField(3)
  List<String> languages = [];

  @HiveField(4)
  String? userDataExperienceTime;

  @HiveField(5)
  double? userDataSallary;

  UserDataModel();

  UserDataModel.empty() {
    userDataUsername = "";
    userDataEmail = "";
    userDataDateOfBirth = null;
    userDataExperienceLevel = "";
    userDataExperienceTime = "";
    userDataSallary = 1320;
  }
}
