import 'package:flutter/material.dart';

class ButtonStateProvider with ChangeNotifier {
  bool buttonState;
  double buttonWidth;
  ButtonStateProvider({this.buttonState = false, this.buttonWidth = 150.0});

  changeButton(bool buttonKiState) {
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
  String docId;
  NoteDataGiver(
      {this.body = 'Body', this.title = 'Title', this.docId = 'Doc ID'});

  noteDataGiver(String _title, String _body, String _docId) {
    title = _title;
    body = _body;
    docId = _docId;

    notifyListeners();
  }
}
