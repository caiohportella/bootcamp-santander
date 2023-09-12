import 'package:hive/hive.dart';
import 'package:trilhaapp/model/settings_model.dart';

class SettingsRepository {
  static late Box _settingsBox;

  SettingsRepository._create();

  static Future<SettingsRepository> load() async {
    if (Hive.isBoxOpen("box_settings")) {
      _settingsBox = Hive.box("box_settings");
    } else {
      _settingsBox = await Hive.openBox("box_settings");
    }

    return SettingsRepository._create();
  }

  void save(SettingsModel settings) {
    _settingsBox.put("settings", {
      "username": settings.username,
      "email": settings.email,
      "getNotifications": settings.getNotifications,
      "isDarkMode": settings.isDarkMode,
    });
  }

  SettingsModel getData() {
    var settings = _settingsBox.get("settings");

    if (settings == null) {
      return SettingsModel.empty();
    }

    return SettingsModel(
      settingsUsername: settings["username"],
      settingsEmail: settings["email"],
      settingsGetNotifications: settings["getNotifications"],
      settingsIsDarkMode: settings["isDarkMode"],
    );
  }
}
