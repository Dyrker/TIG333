import 'package:flutter/foundation.dart';

class CharacterManager extends ChangeNotifier {
  String selectedCharacter = "Ninja Frog";
  String imageCharacter = "Ninjafrog.png";

  void setSelectedCharacter(String character) {
    selectedCharacter = character;
    notifyListeners();
  }

  void setImageCharacter(String characterimg) {
    imageCharacter = characterimg;
    notifyListeners();
  }
}
