import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/notes.dart';

class DatabaseServices {
  static final DatabaseServices _instance = DatabaseServices._internal();
  static Database? _database;

  factory DatabaseServices() {
    return _instance;
  }

  DatabaseServices._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'note_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        tag TEXT,
        reminderTime DATE,
        creationDate DATE
        isPinned INTEGER NOT NULL
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    try {
      Database db = await database;
      var res = await db.query('notes');

      if (res.isEmpty) {
        return [];
      } else {
        var resultMap = res.toList();
        return resultMap.isNotEmpty ? resultMap : [];
      }
    } catch (e) {
      print('Error getting notes: $e');
      return [];
    }
  }

  insertNote(Note note) async {
    try {
      Database db = await database;
      await db.insert(
        'notes',
        note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting note: $e');
    }
  }

  Future<void> deleteNote(int id) async {
    Database db = await database;
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateNote(Note note) async {
    Database db = await database;
    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
}
