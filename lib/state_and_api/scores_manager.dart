import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class ScoresManager extends ChangeNotifier {
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  int platformCount = 0;
  int sessionHighscore = 0;

  void resetScore() {
    platformCount = 0;
    notifyListeners();
  }

  void updateSessionHighscore() {
    if (platformCount > sessionHighscore) {
      sessionHighscore = platformCount;
    }
  }

  List<Score> localScores = [];

  void submitScore(String name, int score) {
    ref.child('scores').push().set({
      'name': name,
      'score': score,
    });
  }

  Future<List<Score>> updateLocalScores() async {
    DataSnapshot data = await ref.child('scores').orderByChild('score').limitToLast(20).get();
    Map<String, dynamic> scores = Map<String, dynamic>.from(data.value as Map);
    List<Score> freshScores = [];
    for (var entry in scores.entries) {
      String nameVal = entry.value['name'];
      int scoreVal = entry.value['score'];
      Score score = Score(name: nameVal, score: scoreVal);
      freshScores.add(score);
    }
    freshScores.sort((a, b) => b.score.compareTo(a.score));
    localScores = freshScores;
    return localScores;
  }
}

class Score {
  final String name;
  final int score;

  Score({required this.name, required this.score});
}
