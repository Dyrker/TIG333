import 'package:flutter/material.dart';
import 'package:flutter_flame/state_and_api/scores_api.dart';
import 'package:flutter_flame/state_and_api/scores_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GameOverScreenOverlay extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ScoresProvider scoresProvider = context.read<ScoresProvider>();
    final int score = scoresProvider.platformCount;
    var scoreApi = Provider.of<ApiUserScore>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              "assets/images/staticBackground.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                height:100,
                child: Text(
                "Your Score: $score",
                style: GoogleFonts.pressStart2p())),
                Container(
                  height: 40, // Adjust the height as needed
                  child: Text(
                    'Type in your name if you want to register your score',
                    style: GoogleFonts.pressStart2p(),
                  ),
                ),
                SizedBox(
                  width: 250, // Adjust width to control size
                  child: TextFormField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    style: GoogleFonts.pressStart2p(),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Send score', style: GoogleFonts.pressStart2p()),
                  onPressed: () async {
                    final String playerName = _textEditingController.text.trim();
                    final String playerAndScore = '$playerName : $score';
                    scoresProvider.addScore(UserScore(name: playerName, score: score));
                    scoreApi.addApiScore(playerAndScore);
                    scoresProvider.resetScore();
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Back to the main menu', style: GoogleFonts.pressStart2p()),
                  onPressed: () {
                    scoresProvider.resetScore();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
