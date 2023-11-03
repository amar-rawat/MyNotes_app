import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/noteEditPage',
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.19,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 219, 198, 255),
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
                            onPressed: () {}, icon: const Icon(Icons.edit)),
                        IconButton(
                          onPressed: () {
                            MyNotes.doc(docID).delete();
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
