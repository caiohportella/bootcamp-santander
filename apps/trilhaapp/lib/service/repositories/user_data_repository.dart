import 'package:hive/hive.dart';
import 'package:trilhaapp/model/user_data_model.dart';

class UserDataRepository {
  static late Box _userDataBox;

  UserDataRepository._create();

  static Future<UserDataRepository> load() async {
    if (Hive.isBoxOpen("box_user_data")) {
      _userDataBox = Hive.box("box_user_data");
    } else {
      _userDataBox = await Hive.openBox("box_user_data");
    }

    return UserDataRepository._create();
  }

  void save(UserDataModel userData) {
    _userDataBox.put("box_user_data", userData);
  }

  UserDataModel getData() {
    var userData = _userDataBox.get("box_user_data");

    if (userData == null) {
      return UserDataModel.empty();
    }

    return userData;
  } 
}
