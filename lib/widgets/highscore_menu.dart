import 'package:flutter/material.dart';
import 'package:flutter_flame/test_adventure.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../state_and_api/scores_provider.dart';

class HighScoreMenu extends StatelessWidget {
  final TestAdventure game;

  const HighScoreMenu({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScoresProvider scoresProvider = context.read<ScoresProvider>();
    List<UserScore> highScores = scoresProvider.scores;
    highScores.sort((a, b) => b.score.compareTo(a.score));

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
            Transform.translate(
              offset: Offset(0, 10),
              child: Text(
                'HIGHSCORES',
                style: GoogleFonts.pressStart2p(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: ListView.builder(
                itemCount: highScores.length,
                itemBuilder: (BuildContext context, int index) {
                  UserScore userScore = highScores[index];
                  return _score(userScore);
                },
              ),
            ),
            ElevatedButton(
              child: Text(
                'Back to menu',
                style: GoogleFonts.pressStart2p(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _score(UserScore userScore) {
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
