import 'package:flutter/material.dart';

class NotesDetailPage extends StatelessWidget {
  const NotesDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _title = TextEditingController();
    TextEditingController _notesBody = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(hintText: 'Title'),
            controller: _title,
          ),
          TextField(
            decoration: const InputDecoration(hintText: 'Write here...'),
            controller: _notesBody,
          )
        ],
      ),
    );
  }
}
