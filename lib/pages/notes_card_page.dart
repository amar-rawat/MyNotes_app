import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:notes_app/providers/all_providers.dart';
import 'package:notes_app/services/Firestore.dart';
import 'package:lottie/lottie.dart';

import 'package:notes_app/widgets/logout_dialog_box.dart';
import 'package:notes_app/widgets/notes_card.dart';
import 'package:provider/provider.dart';

class NotesCardPage extends StatelessWidget {
  const NotesCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    FirestoreService firestoreService = FirestoreService();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    logout() {
      LogoutAlertDialog.logoutAlertDialog(context);
    }

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text(
          'Hot Notes',
          // style: GoogleFonts.abel(),
        ),
        leading: Lottie.asset(
          'assets/lottie_json/note_image.json',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.MyNotes.where('User ID', isEqualTo: userId)
            // .orderBy("Time Stamp", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // if the snapshot has data, get all the docs
          if (snapshot.hasData && snapshot.data!.docs.length >= 1) {
            // get snapshot of all documents

            List notesList = snapshot.data!.docs;

            return Stack(children: [
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
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
                      },
                    ),
                  ),
                  Container(
                    color: Colors.deepPurple.shade50,
                    height: 50,
                  )
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(1),
                      ],
                    ),
                  ),
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Positioned(
                bottom: 20,
                left: MediaQuery.of(context).size.width * 0.5 - 35,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/noteAddPage');
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ]);
          }
          // if the snapshot doesn't have data,
          else if (!snapshot.hasData || snapshot.data!.docs.length == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  const SizedBox(),
                  Container(
                    child: const Column(
                      children: [
                        Text(
                          'No Notes',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 24),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('"Add new note"'),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Transform(
                            transform: Matrix4.translationValues(0, 30, 0),
                            child: const Text("Click here to add")),
                        Transform(
                          transform: Matrix4.rotationZ(-pi / 18),
                          origin: const Offset(150, 130),
                          child: Lottie.asset(
                            'assets/lottie_json/arrow.json',
                            height: 200,
                            width: 200,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/noteAddPage');
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(15)),
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else
            return const Center(child: Text('Error'));
        },
      ),
    );
  }
}
