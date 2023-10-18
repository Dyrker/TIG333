import 'package:flutter/material.dart';
import 'package:flutter_flame/state_and_api/scores_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_flame/test_adventure.dart';



class GameOverScreenOverlay extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  final Function resetScoreCallback;

  GameOverScreenOverlay({required this.resetScoreCallback});


  
  @override
  
  Widget build(BuildContext context) {
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
              children: <Widget>[TextFormField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)
                    ), 
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    hintText: 'Type in your name if you want to register your score',
                  ),
                  style: TextStyle(color: Colors.black)),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Send score', style: GoogleFonts.pressStart2p()),
                  onPressed: () {
                    final String playerName = _textEditingController.text.trim();
                    final ScoresProvider scoresProvider = context.read<ScoresProvider>();
                    final int score = scoresProvider.platformCount;
                    scoresProvider.addScore(UserScore(name: playerName, score: score));
                    scoresProvider.resetScore();        
                    Navigator.of(context).pop(); }),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Back to main menu', style: GoogleFonts.pressStart2p()),
                  onPressed: () {
                    resetScoreCallback();
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
