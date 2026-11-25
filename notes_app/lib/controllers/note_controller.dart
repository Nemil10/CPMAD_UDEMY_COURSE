import 'package:flutter/foundation.dart';

import '../helpers/database_helper.dart';
import '../models/note_model.dart';

class NoteController extends ChangeNotifier {
  final _db = DatabaseHelper.instance;
  List<Note> notes = [];

  Future<void> loadNotes() async {
    notes = await _db.getNotes();
    notifyListeners();
  }

  Future<void> saveNote(Note note) async {
    if (note.id == null) {
      await _db.insertNote(note);
    } else {
      await _db.updateNote(note);
    }
    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await _db.deleteNote(id);
    await loadNotes();
  }
}
