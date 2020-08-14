import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:todolistapp/db/task.dart';
import 'package:todolistapp/pages/setting_page.dart';
import 'dart:async';

class DbProvider {
  static Database _database;


  static Future<Database> initDb() async{
    String path = join(await getDatabasesPath(), 'task.db');

    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  static Future<void> _createTable(Database db, int version) async{
    return await db.execute("CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, status INTEGER, title TEXT, added_date TEXT, completed_date TEXT, reminder TEXT)");
  }

  static Future<Database> setDb() async {
    if (_database == null) {
      _database = await initDb();
      return _database;
    } else {
      return _database;
    }
  }
  static final _tableName = "task";

  static Future<void> insertTask(Task task) async{
    await _database.insert(
      _tableName,
      {
        'status': task.status,
        'title': task.title,
        'added_date': DateFormat('yyyy-MM-dd HH:mm').format(task.addedDate),
      }
    );
  }
  static Future<List<Task>> getDb() async{
    final List<Map<String, dynamic>> maps = await _database.query(_tableName);

    return List.generate(maps.length, (i){
      return Task(
          id: maps[i]['id'],
          status: maps[i]['status'],
          title: maps[i]['title'],
          addedDate: DateTime.parse(maps[i]['added_date']),
          completedDate: (maps[i]['completed_date'] == null) ? null : DateTime.parse(maps[i]['completed_date']),
      );
    });
  }


  // updateメソッド
  static Future<void> updateStatus(Task task, int id) async{
    await _database.update(
        _tableName, {
      'status': task.status,
      'completed_date': (task.completedDate == null) ? null : DateFormat('yyyy-MM-dd HH:mm').format(task.completedDate)
    },
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<void> updateTask(Task task, int id) async{
    await _database.update(
      _tableName, {
      'title': task.title,
    },
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<void> deleteTask(int id) async {
    await _database.delete(
        _tableName,
        where: "id = ?",
        whereArgs: [id]
    );
  }

  static Future<void> deleteTable() async{
    await _database.delete(_tableName);
  }

  //派生ページのデータベース取得
  static Future<List<Task>> getcompDb() async{
    final List<Map<String, dynamic>> maps = await _database.query('$_tableName', where: 'status = 1');

    return List.generate(maps.length, (i){
      return Task(
        id: maps[i]['id'],
        status: maps[i]['status'],
        title: maps[i]['title'],
        addedDate: DateTime.parse(maps[i]['added_date']),
        completedDate: (maps[i]['completed_date'] == null) ? null : DateTime.parse(maps[i]['completed_date']),
      );
    });
  }

  static Future<List<Task>> getSelfDb(int id) async{
    final List<Map<String, dynamic>> maps = await _database.query('$_tableName', where: 'id = ?', whereArgs: [id]);

    return List.generate(maps.length, (i){
      return Task(
        id: maps[i]['id'],
        status: maps[i]['status'],
        title: maps[i]['title'],
        addedDate: DateTime.parse(maps[i]['added_date']),
        completedDate: (maps[i]['completed_date'] == null) ? null : DateTime.parse(maps[i]['completed_date']),
      );
    });
  }

}