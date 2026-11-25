import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:notes_app/controllers/note_controller.dart';
import 'package:notes_app/helpers/database_helper.dart';
import 'package:notes_app/models/note_model.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  tearDown(() async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('notes');
  });

  test('Note model serialization and deserialization', () {
    const note = Note(id: 1, title: 'Test Title', content: 'Test Content');
    final map = note.toMap();
    expect(map['id'], 1);
    expect(map['title'], 'Test Title');
    expect(map['content'], 'Test Content');

    final parsed = Note.fromMap(map);
    expect(parsed.id, 1);
    expect(parsed.title, 'Test Title');
    expect(parsed.content, 'Test Content');
  });

  test('NoteController CRUD operations', () async {
    final controller = NoteController();

    // Initial state
    await controller.loadNotes();
    expect(controller.notes, isEmpty);

    // Insert note
    await controller.saveNote(const Note(title: 'First Note', content: 'Hello World'));
    expect(controller.notes.length, 1);
    expect(controller.notes.first.title, 'First Note');
    expect(controller.notes.first.content, 'Hello World');

    final noteId = controller.notes.first.id!;

    // Update note
    await controller.saveNote(Note(id: noteId, title: 'Updated Note', content: 'Updated Content'));
    expect(controller.notes.length, 1);
    expect(controller.notes.first.title, 'Updated Note');
    expect(controller.notes.first.content, 'Updated Content');

    // Delete note
    await controller.deleteNote(noteId);
    expect(controller.notes, isEmpty);
  });
}

