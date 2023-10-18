import 'package:flutter/widgets.dart';



class UserScore {
  final String name;
  String? score;

  UserScore({required this.name, this.score});

}

class ScoresProvider extends ChangeNotifier {
  List<UserScore> _name = [];
  List<UserScore> get name => _name;

  void addScore(UserScore userScore) {
    _name.add(userScore);
    notifyListeners();
  }
}
