import 'package:flutter/widgets.dart';
import 'package:flutter_flame/test_adventure.dart';



class UserScore {
  final String name;
  int score;

  UserScore({required this.name, this.score = 0});

}

class ScoresProvider extends ChangeNotifier {
  List<UserScore> _scores = [];
  List<UserScore> get scores => _scores;


  void addScore(UserScore userScore) {
    _scores.add(userScore);
    notifyListeners();
  }

  
}
