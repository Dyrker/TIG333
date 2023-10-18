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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: (DecorationImage(
                image: AssetImage("assets/images/staticBackground.jpg"), fit: BoxFit.cover))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[for (UserScore userScore in highScores)
          _score(userScore),
          ],
        ),
      ),
    );
  }
}

Widget _score(UserScore userScore) {
  final playerName = userScore.name;
  final score = userScore.score; 
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(playerName, style: GoogleFonts.pressStart2p()),
          SizedBox(width: 10),
          Text(
            "Score: $score",
            style: GoogleFonts.pressStart2p(),
          )
        ],
      ),
    )
  ]);
}
