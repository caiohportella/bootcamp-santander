import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:trilhaapp/model/task_model.dart';
import 'package:trilhaapp/model/user_data_model.dart';
import '/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(UserDataModelAdapter());
  Hive.registerAdapter(TaskHiveModelAdapter());

  runApp(const MyApp());
}
