import 'package:flutter/material.dart';

import '../controllers/note_controller.dart';
import '../models/note_model.dart';
import 'note_deatials_screen.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final NoteController _controller = NoteController();
  late Future<void> _notesFuture;

  @override
  void initState() {
    super.initState();
    _notesFuture = _controller.loadNotes();
  }

  Future<void> _refresh() async {
    setState(() {
      _notesFuture = _controller.loadNotes();
    });
  }

  Future<void> _openDetails([Note? note]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => NoteDetailsScreen(note: note)),
    );
    await _refresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: FutureBuilder<void>(
        future: _notesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final notes = _controller.notes;
          if (notes.isEmpty) {
            return const Center(child: Text('No notes yet'));
          }
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(
                  note.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => _openDetails(note),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    if (note.id != null) {
                      await _controller.deleteNote(note.id!);
                      await _refresh();
                    }
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openDetails(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
