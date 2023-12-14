import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  //  get the collection of notes from database
  CollectionReference MyNotes =
      FirebaseFirestore.instance.collection("MyNotes");

  // Create
  Future<void> addNote(String noteTitle, String noteBody) {
    return MyNotes.add({
      'Note Title': noteTitle,
      'Note Body': noteBody,
      'Time Stamp': Timestamp.now(),
      'User ID': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  // Read

  // Update
  Future<void> updateNote(docID, String noteTitle, String noteBody) {
    return MyNotes.doc(docID).update({
      'Note Title': noteTitle,
      'Note Body': noteBody,
      'Time Stamp': Timestamp.now()
    });
  }

  //Delete
}
