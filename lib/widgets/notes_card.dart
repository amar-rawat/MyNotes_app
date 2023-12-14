import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/providers/all_providers.dart';
import 'package:notes_app/widgets/card_colors.dart';
import 'package:provider/provider.dart';

class NotesCard extends StatelessWidget {
  NotesCard(
      {super.key,
      required this.title,
      required this.body,
      required this.docID});
  String title;
  String body;
  String docID;

  @override
  Widget build(BuildContext context) {
    CollectionReference MyNotes =
        FirebaseFirestore.instance.collection("MyNotes");
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: InkWell(
        onTap: () {
          context.read<NoteDataGiver>().noteDataGiver(title, body, docID);
          Navigator.pushNamed(
            context,
            '/noteEditPage',
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.19,
          width: double.infinity,
          decoration: BoxDecoration(
            color: CardColors.cardColorList[
                Random().nextInt(CardColors.cardColorList.length - 1)],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              context
                                  .read<NoteDataGiver>()
                                  .noteDataGiver(title, body, docID);
                              Navigator.pushNamed(
                                context,
                                '/noteEditPage',
                              );
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(
                                      'Are you sure, You want to delete this note ?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('No')),
                                    TextButton(
                                        onPressed: () {
                                          MyNotes.doc(docID).delete();
                                          Navigator.pop(context);
                                        },
                                        child: Text('Yes'))
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.delete),
                        )
                      ],
                    )
                  ],
                ),
                const Divider(thickness: 1, color: Colors.deepPurple),
                Flexible(child: Text(body))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
