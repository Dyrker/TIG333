import 'package:flutter/widgets.dart';



class UserScore {
  final String name;
  final String score;

  UserScore({required this.name, required this.score});

}

class ScoresProvider extends ChangeNotifier {
  List<UserScore> _score = [];
  List<UserScore> get score => _score;

  void addScore(UserScore score) {
    //score.add(score);
    notifyListeners();
  }
}
