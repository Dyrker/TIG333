import 'package:flutter/widgets.dart';
import 'package:flutter_flame/test_adventure.dart';



class UserScore {
  final String name;
  int score;
  

  UserScore({required this.name, required this.score});

}

class ScoresProvider extends ChangeNotifier {
  List<UserScore> _scores = [];
  int platformCount = 0;
  String selectedCharacter = "Ninja Frog";
  String imageCharacter = "Ninjafrog.png";
  List<UserScore> get scores => _scores;


  void addScore(UserScore userScore) {
    _scores.add(userScore);
    notifyListeners();
  }

  void resetScore(){
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
