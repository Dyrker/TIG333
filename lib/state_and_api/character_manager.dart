import 'package:flutter/foundation.dart';

class CharacterManager extends ChangeNotifier {
  int selectedCharacterIndex = 0; // Index of the selected character
  List<String> characterNames = ["Ninja Frog", "Pink Man", "Virtual Guy", "Mask Dude"];
  List<String> characterImageNames = [
    "Ninjafrog.png",
    "Pinkman.png",
    "Virtualguy.png",
    "Maskeddude.png",
  ];

  String get selectedCharacter => characterNames[selectedCharacterIndex];
  String get imageCharacter => characterImageNames[selectedCharacterIndex];

  void setSelectedCharacterIndex(int index) {
    selectedCharacterIndex = index;
    notifyListeners();
  }

  void nextCharacter() {
    selectedCharacterIndex = (selectedCharacterIndex + 1) % characterNames.length;
    notifyListeners();
  }

  void previousCharacter() {
    selectedCharacterIndex =
        (selectedCharacterIndex - 1 + characterNames.length) % characterNames.length;
    notifyListeners();
  }
}
