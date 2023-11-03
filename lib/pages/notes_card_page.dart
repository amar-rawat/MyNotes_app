import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:notes_app/providers/all_providers.dart';
import 'package:notes_app/services/Firestore.dart';
import 'package:notes_app/widgets/logout_dialog_box.dart';
import 'package:notes_app/widgets/notes_card.dart';
import 'package:provider/provider.dart';

class NotesCardPage extends StatelessWidget {
  const NotesCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    FirestoreService firestoreService = FirestoreService();
    logout() {
      LogoutAlertDialog.logoutAlertDialog(context);
    }

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 192, 157, 252),
        appBar: AppBar(
          title: const Text('My Notes'),
          leading: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Image.asset(
              'assets/images/notes_image.png',
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  logout();
                  context.read<ButtonStateProvider>().changeButton(false);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/noteAddPage');
            },
            elevation: 10,
            backgroundColor: Colors.deepPurple,
            tooltip: 'Add new note',
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(40)),
            child: const Icon(Icons.add)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: StreamBuilder<QuerySnapshot>(
            stream:
                firestoreService.MyNotes.orderBy("Time Stamp", descending: true)
                    .snapshots(),
            builder: (context, snapshot) {
              // if the snapshot has data, get all the docs
              if (snapshot.hasData) {
                // get snapshot of all documents
                List notesList = snapshot.data!.docs;

                return ListView.builder(
                    itemCount: notesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      //get individual document by index
                      DocumentSnapshot document = notesList[index];
                      String docId = document.id;

                      // get data from document in the form of map

                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;

                      String _title = data['Note Title'];
                      String _body = data['Note Body'];

                      return NotesCard(
                          title: _title, body: _body, docID: docId);
                    });
              }
              // if the snapshot doesn't have data,
              else
                return Text('No Notes');
            }));
  }
}
