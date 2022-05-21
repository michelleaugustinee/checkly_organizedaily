import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/db_models.dart';

class dbHelper{
  static final dbHelper instance = dbHelper._instance();
  dbHelper._instance();

  static Database? _db;
  Future<Database> get db async => _db ??= await initDb();

  Future<Database> initDb() async {
    String dbPath = await getDatabasesPath();
    return await openDatabase(
        join(dbPath, 'ToDoList.db'),
        version: 1,
        onCreate: _onCreate
    );
  }

  void _onCreate(Database db, int version)async{
    await db.execute('''
      CREATE TABLE 
      Topics (
      ID INTEGER PRIMARY KEY AUTOINCREMENT,
      TopicName TEXT,
      OrderIndex INTEGER 
      )
    ''');
    await db.execute('''
      CREATE TABLE 
      Tasks (
      ID INTEGER PRIMARY KEY AUTOINCREMENT,
      TaskName TEXT,
      OrderIndex INTEGER,
      Status INTEGER,
      Color TEXT,
      TopicID TEXT
      )
    ''');
  }
// ------TOPIC------
  Future<List<Topic>> getTopics() async {
    Database db = await this.db;
    // await db.execute("DROP TABLE IF EXISTS Tasks");
    // await db.execute('''
    //   CREATE TABLE
    //   Tasks (
    //   ID INTEGER PRIMARY KEY AUTOINCREMENT,
    //   TaskName TEXT,
    //   OrderIndex INTEGER,
    //   Status INTEGER,
    //   Color TEXT,
    //   TopicID TEXT
    //   )
    // ''');
    var Topics = await db.query('Topics', orderBy: 'OrderIndex');
    List<Topic> TopicsList = Topics.isNotEmpty?
    Topics.map((d) => Topic.fromMap(d)).toList() : [];
    return TopicsList;
  }

  Future<int> addTopic (Topic Topic) async {
    Database db = await this.db;
    return await db.insert('Topics', Topic.toMap());
  }
  Future<int> removeTopic (int id) async {
    Database db = await this.db;
    return await db.delete('Topics', where: 'id = ?', whereArgs: [id]);
  }
  Future<int> updateTopic (Topic Topic, String newName) async {
    Database db = await this.db;
    return await db.rawUpdate(
        'UPDATE Topics SET TopicName = ? WHERE id = ?',
        [newName, Topic.id]);
  }
  Future<int> reoderTopic (int id ,int newIndex) async {
    Database db = await this.db;
    return await db.rawUpdate(
        'UPDATE Topics SET OrderIndex = ? WHERE id = ?',
        [newIndex, id]);
  }

// ------TASKS------
  Future<List<Task>> getTasks(String TopicID) async {
    Database db = await this.db;

    var Tasks = await db.query('Tasks', orderBy: 'OrderIndex', where: 'TopicID = ?', whereArgs: [TopicID]);
    List<Task> TasksList = Tasks.isNotEmpty?
    Tasks.map((d) => Task.fromMap(d)).toList() : [];
    return TasksList;
  }

  Future<int> addTask (Task Task) async {
    Database db = await this.db;
    return await db.insert('Tasks', Task.toMap());
  }
  Future<int> removeTask (int id) async {
    Database db = await this.db;
    return await db.delete('Tasks', where: 'id = ?', whereArgs: [id]);
  }
  Future<int> updateTask (int id, String newName, String Color) async {
    Database db = await this.db;
    return await db.rawUpdate(
        'UPDATE Tasks SET TaskName = ?, Color = ? WHERE id = ?',
        [newName, Color, id]);
  }
  Future<int> updateTaskStatus (int id, int Status) async {
    Database db = await this.db;
    return await db.rawUpdate(
        'UPDATE Tasks SET Status = ? WHERE id = ?',
        [Status, id]);
  }
  Future<int> reoderTask (int id ,int newIndex) async {
    Database db = await this.db;
    return await db.rawUpdate(
        'UPDATE Tasks SET OrderIndex = ? WHERE id = ?',
        [newIndex, id]);
  }

}