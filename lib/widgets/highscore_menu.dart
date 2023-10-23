import 'package:flutter/material.dart';
import 'package:flutter_flame/state_and_api/scores_manager.dart';
import 'package:flutter_flame/test_adventure.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:core';

class HighScoreMenu extends StatelessWidget {
  final TestAdventure game;

  const HighScoreMenu({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScoresManager scoresManager = context.read<ScoresManager>();

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
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              height: 400,
              child: ListView.builder(
                itemCount: scoresManager.localScores.length,
                itemBuilder: (BuildContext context, int index) {
                  final scoreObject = scoresManager.localScores[index];
                  return _scorestring(scoreObject.name, scoreObject.score.toString());
                },
              ),
            ),
            SizedBox(height: 40),
            Transform.translate(
              offset: Offset(0, 10),
              child: Text(
                'Your highscore: TBA',
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

//Don't remove this, this widget might be used to keep track of your attempts that don't make it to highscore
Widget _score(Score userScore) {
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
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(playerName,
                style: GoogleFonts.pressStart2p(
                  fontSize: 20.0,
                  color: Colors.white,
                )),
            Text(score,
                style: GoogleFonts.pressStart2p(
                  fontSize: 20.0,
                  color: Colors.white,
                )),
          ],
        ),
        SizedBox(height: 15),
      ],
    ),
  );
}
