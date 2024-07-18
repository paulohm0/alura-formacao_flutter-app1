import 'dart:io';

import 'package:alura/components/task_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSQFlite {
  static final _databaseName = "taskTable";
  static final _databaseVersion = 1;

  static final columnId = "_id";
  static final columnName = "nome";
  static final columnImage = "imagem";

  // private constructor
  // Used to have just a single instance of the class (padrao Singleton)
  DatabaseSQFlite._();

  static final DatabaseSQFlite instance = DatabaseSQFlite._();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $_databaseName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnImage TEXT NOT NULL)
          ''');
  }

  /// CRUD Methods

  // Insert
  Future insertTask(TaskModel task) async {
    Database? db = await instance.database;
    Map<String, dynamic> mapTask = toMap(task);
    return await db.insert(_databaseName, mapTask);
  }

  // Read all
  Future<List<TaskModel>> readAllTasks() async {
    Database? db = await instance.database;
    final taskMap = await db.query(_databaseName);
    List<TaskModel> listTask = toList(taskMap);
    return listTask;
  }

  // Update
  Future<int> updateTask(TaskModel task) async {
    Database? db = await instance.database;
    return await db.update(_databaseName, toMap(task),
        where: '$columnId = ?', whereArgs: [task.id]);
  }

  // Delete
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db
        .delete(_databaseName, where: '$columnId = ?', whereArgs: [id]);
  }

  /// Helper Methods

  // Turn a map into an object
  List<TaskModel> toList(List<Map<String, dynamic>> taskMap) {
    final List<TaskModel> tasks = [];
    for (Map<String, dynamic> row in taskMap) {
      final TaskModel task = TaskModel(
        row[columnId],
        row[columnName],
        row[columnImage],
      );
      tasks.add(task);
    }
    return tasks;
  }

  // Turn an object into a map
  Map<String, dynamic> toMap(TaskModel task) {
    final Map<String, dynamic> taskMap = {};
    taskMap[columnId] = task.id;
    taskMap[columnName] = task.nome;
    taskMap[columnImage] = task.imagem;
    return taskMap;
  }
}
