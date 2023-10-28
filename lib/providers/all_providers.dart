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
