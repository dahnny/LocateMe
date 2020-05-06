import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbHelper {
  static Future<sql.Database> database() async {
//    This gets the path to the database
    final dbPath = await sql.getDatabasesPath();
//    This creates the path with the name of the database
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
//      This creates the table with the fields
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
//    This inserts the data into the database
    final db = await DbHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
//    This queries the database to retrieve all elements in the database
    final db = await DbHelper.database();
    return db.query(table);
  }
}
