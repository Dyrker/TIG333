import 'package:flutter/material.dart';
import 'package:flutter_flame/state_and_api/scores_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_flame/widgets/jumper_menu_buttons.dart'; // Import the ButtonStyles class

class GameOverScreenOverlay extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ScoresManager scoresManager = context.read<ScoresManager>();
    final int score = scoresManager.platformCount;
    scoresManager.updateSessionHighscore();

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
                    height: 100,
                    child: Text("Score: $score",
                        style: GoogleFonts.pressStart2p(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        )))),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50, top: 50, bottom: 20),
                  child: Container(
                    height: 40,
                    child: Text(
                      'Optionally enter name to save score',
                      style: GoogleFonts.pressStart2p(
                          textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    maxLength: 15,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      counterStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: GoogleFonts.pressStart2p(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                ButtonStyles.retroElevatedButton(
                  onPressed: () async {
                    final String playerName = _textEditingController.text.trim();

                    if (playerName.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Player name cannot be empty'),
                        ),
                      );
                    } else if (playerName.contains(' ')) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Player name cannot contain spaces'),
                        ),
                      );
                    } else {
                      scoresManager.submitScore(playerName, score);

                      scoresManager.resetScore();
                      Navigator.of(context).pop();
                    }
                  },
                  label: 'Save score',
                  fontSize: 16.0,
                ),
                SizedBox(height: 35),
                ButtonStyles.retroElevatedButton(
                  onPressed: () {
                    scoresManager.resetScore();
                    Navigator.of(context).pop();
                  },
                  label: 'Return to menu',
                  fontSize: 16.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
