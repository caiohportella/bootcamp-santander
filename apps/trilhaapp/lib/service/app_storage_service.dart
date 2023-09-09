import 'package:shared_preferences/shared_preferences.dart';

enum STORAGE_KEYS {
  K_NAME,
  K_EMAIL,
  K_BIRTH_DATE,
  K_SELECTED_LEVEL,
  K_SELECTED_LANGUAGE,
  K_EXPERIENCE_TIME,
  K_CHOSEN_SALARY,
  K_USERNAME,
  K_DARK_MODE,
  K_PUSH_NOTIFICATION,
  K_CLICKS,
  K_RANDOM_NUMBER,  
}

class AppStorageService {
  Future<void> _setString (String key, String value) async {
    SharedPreferences sharedStorage = await SharedPreferences.getInstance();
    sharedStorage.setString(key, value);
  }

  Future<String> _getString(String key) async {
    SharedPreferences sharedStorage = await SharedPreferences.getInstance();
    return sharedStorage.getString(key) ?? "";
  }

  Future<void> _setStringList (String key, List<String> values) async {
    SharedPreferences sharedStorage = await SharedPreferences.getInstance();
    sharedStorage.setStringList(key, values);
  }
  Future<List<String>> _getStringList(String key) async {
    SharedPreferences sharedStorage = await SharedPreferences.getInstance();
    return sharedStorage.getStringList(key) ?? [];
  }

  Future<void> _setInt (String key, int value) async {
    SharedPreferences sharedStorage = await SharedPreferences.getInstance();
    sharedStorage.setInt(key, value);
  }
  Future<int> _getInt(String key) async {
    SharedPreferences sharedStorage = await SharedPreferences.getInstance();
    return sharedStorage.getInt(key) ?? 0;
  } 

  Future<void> _setDouble (String key, double value) async {
    SharedPreferences sharedStorage = await SharedPreferences.getInstance();
    sharedStorage.setDouble(key, value);
  }
  Future<double> _getDouble(String key) async {
    SharedPreferences sharedStorage = await SharedPreferences.getInstance();
    return sharedStorage.getDouble(key) ?? 1320;
  }

  Future<void> _setBool (String key, bool value) async {
    SharedPreferences sharedStorage = await SharedPreferences.getInstance();
    sharedStorage.setBool(key, value);
  }
  Future<bool> _getBool(String key) async {
    SharedPreferences sharedStorage = await SharedPreferences.getInstance();
    return sharedStorage.getBool(key) ?? false;
  }

  Future<void> setRegisterName(String name) async {
    await _setString(STORAGE_KEYS.K_NAME.toString(), name);
  }
  Future<String> getRegisterName() async {
    return _getString(STORAGE_KEYS.K_NAME.toString());
  }

  Future<void> setEmail(String email) async {
    await _setString(STORAGE_KEYS.K_EMAIL.toString(), email);
  }
  Future<String> getEmail() async {
    return _getString(STORAGE_KEYS.K_EMAIL.toString());
  }

  Future<void> setRegisterBirthDate(DateTime birthDate) async {
    await _setString(STORAGE_KEYS.K_BIRTH_DATE.toString(), birthDate.toString());
  }
  Future<String> getRegisterBirthDate() async {
    return _getString(STORAGE_KEYS.K_BIRTH_DATE.toString());
  }

  Future<void> setRegisterSelectedLevel(String selectedLevel) async {
    await _setString(STORAGE_KEYS.K_SELECTED_LEVEL.toString(), selectedLevel);
  }
  Future<String> getRegisterSelectedLevel() async {
    return _getString(STORAGE_KEYS.K_SELECTED_LEVEL.toString());
  }

  Future<void> setRegisterSelectedLanguage(List<String> selectedLanguage) async {
    await _setStringList(STORAGE_KEYS.K_SELECTED_LANGUAGE.toString(), selectedLanguage);
  }
  Future<List<String>> getRegisterSelectedLanguage() async {
    return _getStringList(STORAGE_KEYS.K_SELECTED_LANGUAGE.toString());
  }

  Future<void> setRegisterExperienceTime(String experienceTime) async {
    await _setString(STORAGE_KEYS.K_EXPERIENCE_TIME.toString(), experienceTime);
  }
  Future<String> getRegisterExperienceTime() async {
    return _getString(STORAGE_KEYS.K_EXPERIENCE_TIME.toString());
  }

  Future<void> setRegisterChosenSalary(double chosenSalary) async {
    await _setDouble(STORAGE_KEYS.K_CHOSEN_SALARY.toString(), chosenSalary);
  }
  Future<double> getRegisterChosenSalary() async {
    return _getDouble(STORAGE_KEYS.K_CHOSEN_SALARY.toString());
  }

  Future<void> setSettingsUsername(String username) async {
    await _setString(STORAGE_KEYS.K_USERNAME.toString(), username);
  }
  Future<String> getSettingsUsername() async {
    return _getString(STORAGE_KEYS.K_USERNAME.toString());
  }

  Future<void> setSettingsDarkMode(bool darkMode) async {
    await _setBool(STORAGE_KEYS.K_DARK_MODE.toString(), darkMode);
  }
  Future<bool> getSettingsDarkMode() async {
    return _getBool(STORAGE_KEYS.K_DARK_MODE.toString());
  }

  Future<void> setSettingsPushNotification(bool pushNotification) async {
    await _setBool(STORAGE_KEYS.K_PUSH_NOTIFICATION.toString(), pushNotification);
  }
  Future<bool> getSettingsPushNotification() async {
    return _getBool(STORAGE_KEYS.K_PUSH_NOTIFICATION.toString());
  }

  Future<void> setRandomNumberInt(int value) async {
    await _setInt(STORAGE_KEYS.K_RANDOM_NUMBER.toString(), value);
  }
  Future<int> getRandomNumberInt() async {
    return _getInt(STORAGE_KEYS.K_RANDOM_NUMBER.toString());
  }

  Future<void> setClicks(int value) async {
    await _setInt(STORAGE_KEYS.K_CLICKS.toString(), value);
  }
  Future<int> getClicks() async {
    return _getInt(STORAGE_KEYS.K_CLICKS.toString());
  } 
}
