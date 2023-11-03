import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:notes_app/providers/all_providers.dart';

import 'package:provider/provider.dart';

class NoteEditPage extends StatelessWidget {
  const NoteEditPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 6),
                      label: Text('Title'),
                      labelStyle: TextStyle(fontSize: 20),
                      floatingLabelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  controller: _title
                    ..text = context.read<NoteDataGiver>().title,
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: TextFormField(
                            controller: _notesBody
                              ..text = context.watch<NoteDataGiver>().body,
                            maxLines: 19,
                            decoration: const InputDecoration(
                              hintText: 'Write here...',
                              contentPadding: EdgeInsets.only(left: 6),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Body of note can not be empty...';
                              }
                              return null;
                            },
                          ),
                        ),
                        FloatingActionButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // FirebaseFirestore.instance.collection('MyNotes').doc()
                                _title.clear();
                                _notesBody.clear();
                              } else {
                                SnackBar(
                                    content: Text(
                                        'Body of note can not be empty...'));
                              }
                            },
                            child: const Text('Save Changes')),
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
