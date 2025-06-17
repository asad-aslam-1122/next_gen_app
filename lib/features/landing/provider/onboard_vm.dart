import 'package:flutter/material.dart';

class OnboardVm extends ChangeNotifier {
  int currentOnBoardIndex = 0;

  void update() {
    notifyListeners();
  }
}
