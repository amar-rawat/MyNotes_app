import 'package:flutter/material.dart';
import 'package:notes_app/services/Firestore.dart';
import 'package:provider/provider.dart';

class NoteAddPage extends StatelessWidget {
  const NoteAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    FirestoreService firestoreService = FirestoreService();
    TextEditingController _title = TextEditingController();
    TextEditingController _notesBody = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 198, 255),
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      body: Consumer(builder: (BuildContext context, value, Widget? child) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 6),
                      label: Text('Title'),
                      labelStyle: TextStyle(fontSize: 20),
                      floatingLabelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  controller: _title,
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: TextFormField(
                            controller: _notesBody,
                            maxLines: 19,
                            decoration: const InputDecoration(
                              hintText: 'Write here...',
                              contentPadding: EdgeInsets.only(left: 6),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "";
                              }
                              return null;
                            },
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                firestoreService.addNote(
                                    _title.text, _notesBody.text);
                                _title.clear();
                                _notesBody.clear();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Body can not be empty...'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                            },
                            child: Text('Add Note')),
                        const SizedBox(
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
