import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note_model.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      version: 1,
      onCreate: (db, version) => db.execute('''
        CREATE TABLE notes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          content TEXT NOT NULL
        )
      '''),
    );
    return _database!;
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final rows = await db.query('notes', orderBy: 'id DESC');
    return rows.map(Note.fromMap).toList();
  }

  Future<int> insertNote(Note note) async =>
      (await database).insert('notes', note.toMap());

  Future<int> updateNote(Note note) async => (await database).update(
    'notes',
    note.toMap(),
    where: 'id = ?',
    whereArgs: [note.id],
  );

  Future<int> deleteNote(int id) async =>
      (await database).delete('notes', where: 'id = ?', whereArgs: [id]);
}
