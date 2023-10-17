import 'package:flutter/cupertino.dart';
import 'package:platform/platform.dart';
import 'highscore_menu.dart';


class JumperApi with ChangeNotifier {
  int _platformCount = 0;

  int get platformCount => _platformCount;

  void updatePlatformCount(int newScore) {
    _platformCount = newScore;
    notifyListeners();
  }
}