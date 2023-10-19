import 'package:flutter/material.dart';
import 'package:flutter_flame/state_and_api/scores_api.dart';
import 'package:flutter_flame/test_adventure.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../state_and_api/scores_provider.dart';
import 'dart:core';

class HighScoreMenu extends StatelessWidget {
  final TestAdventure game;

  const HighScoreMenu({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScoresProvider scoresProvider = context.read<ScoresProvider>();
    List<LocalUserScore> highScores = scoresProvider.scores;
    highScores.sort((a, b) => b.score.compareTo(a.score));
    final ApiUserScore highScoreApi = context.read<ApiUserScore>();
    highScoreApi.removeApiScoresBelowTop();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/staticBackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            Transform.translate(
              offset: Offset(0, 10),
              child: Text(
                'HIGHSCORES',
                style: GoogleFonts.pressStart2p(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
            height: 300,
            child: ListView.builder(
                itemCount: highScoreApi.apiScores.length,
                itemBuilder: (BuildContext context, int index) {
                  final apiScoreItem = highScoreApi.apiScores[index];
                  final parts = apiScoreItem.title
                      .split(' '); // Split the title into parts
                  final playerName = parts[0];
                  final score = int.tryParse(parts[1]) ?? 0;
                  return _scorestring(playerName, score.toString());
                },
              ),
            ),
            SizedBox(height: 40),
            Transform.translate(
              offset: Offset(0, 10),
              child: Text(
                'Your Score: ',
                style: GoogleFonts.pressStart2p(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                child: Text(
                  'Return to menu',
                  style: GoogleFonts.pressStart2p(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _score(LocalUserScore userScore) {
  final playerName = userScore.name;
  final score = userScore.score;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(playerName, style: GoogleFonts.pressStart2p(fontSize: 24.0)),
            SizedBox(width: 10),
            Text(
              ": $score",
              style: GoogleFonts.pressStart2p(fontSize: 24.0),
            ),
          ],
        ),
      ),
      SizedBox(height: 10),
    ],
  );
}

Widget _scorestring(String playerName, String score) {
  final scoreName = '$playerName $score';
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(scoreName, style: GoogleFonts.pressStart2p(fontSize: 24.0)),
            SizedBox(width: 10),
          ],
        ),
      ),
      SizedBox(height: 10),
    ],
  );
}
