import 'package:flutter/widgets.dart';

class LocalUserScore {
  final String name;
  int score;

  LocalUserScore({required this.name, required this.score});
}

class ScoresProvider extends ChangeNotifier {
  List<LocalUserScore> _scores = [];
  int platformCount = 0;
  String selectedCharacter = "Ninja Frog";
  String imageCharacter = "Ninjafrog.png";
  List<LocalUserScore> get scores => _scores;

  void addScore(LocalUserScore userScore) {
    _scores.add(userScore);
    notifyListeners();
  }

  void resetScore() {
    platformCount = 0;
    notifyListeners();
  }

  void setSelectedCharacter(String character) {
    selectedCharacter = character;
    notifyListeners();
  }

  void setImageCharacter(String characterimg) {
    imageCharacter = characterimg;
    notifyListeners();
  }
}
