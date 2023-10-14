class SettingsModel {
  String settingsUsername = "";
  String settingsEmail = "";
  bool settingsGetNotifications = false;
  bool settingsIsDarkMode = false;

  SettingsModel.empty() {
    settingsUsername = "";
    settingsEmail = "";
    settingsGetNotifications = false;
    settingsIsDarkMode = false;
  }

  SettingsModel({
    required this.settingsUsername,
    required this.settingsEmail,
    required this.settingsGetNotifications,
    required this.settingsIsDarkMode,
  });

  String get username => settingsUsername;
  String get email => settingsEmail;
  bool get getNotifications => settingsGetNotifications;
  bool get isDarkMode => settingsIsDarkMode;

  set username(String username) => settingsUsername = username;
  set email(String email) => settingsEmail = email;
  set getNotifications(bool getNotifications) =>
      settingsGetNotifications = getNotifications;
  set isDarkMode(bool isDarkMode) => settingsIsDarkMode = isDarkMode;  
}
