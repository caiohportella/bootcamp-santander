import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Map<int, String> scripts = {
  1: 'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT, isDone INTEGER);',
};

class SQFLiteDatabase {
  static Database? db;

  Future<Database> getDatabase() async {
    if(db == null) {
      db = await startDatabase();
    } else {
      return db!;
    }

    return db!;
  }

  Future<Database> startDatabase() async {
    var db = await openDatabase(
      path.join(await getDatabasesPath(), 'trilhaapp.db'),
      version: scripts.length,
      onCreate: (db, version) {
        scripts.forEach((key, value) async {
          await db.execute(value);
        });
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion <= newVersion) {
          scripts.forEach((key, value) async {
            await db.execute(value);
          });
        }
      },
    );

    return db;
  }
}