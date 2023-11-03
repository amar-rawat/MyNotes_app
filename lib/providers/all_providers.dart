import 'package:flutter/material.dart';

class ButtonStateProvider with ChangeNotifier {
  bool buttonState;
  double buttonWidth;
  ButtonStateProvider({this.buttonState = false, this.buttonWidth = 150.0});

  changeButton(bool buttonKiState) async {
    buttonState = buttonKiState;
    if (buttonKiState == true) {
      buttonWidth = 40.0;
    } else if (buttonKiState == false) {
      buttonWidth = 150.0;
    }

    notifyListeners();
  }
}

class NoteDataGiver with ChangeNotifier {
  String title;
  String body;
  String docID;
  NoteDataGiver({
    this.body = 'body',
    this.title = 'title',
    this.docID = 'doc id',
  });

  noteDataGiver(String title, String body, String docID) {
    title = title;
    body = body;

    docID = docID;
    notifyListeners();
  }
}
