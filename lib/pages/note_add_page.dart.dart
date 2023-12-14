import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/services/Firestore.dart';
import 'package:notes_app/widgets/card_colors.dart';
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
      backgroundColor: CardColors
          .cardColorList[Random().nextInt(CardColors.cardColorList.length - 1)],
      appBar: AppBar(
        title: const Text(
          'Hot Notes',
          // style: GoogleFonts.abel(),
        ),
        leading: Lottie.asset(
          'assets/lottie_json/note_image.json',
        ),
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      try {
                        if (_formKey.currentState!.validate() &&
                            (_title.text != '' && _notesBody.text != '')) {
                          firestoreService.addNote(
                            _title.text,
                            _notesBody.text,
                          );
                          _title.clear();
                          _notesBody.clear();
                          Navigator.pop(context);
                        } else if (_title.text.isEmpty ||
                            _notesBody.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Title and Body can not be empty...'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(e.toString()),
                            );
                          },
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
        );
      }),
    );
  }
}
