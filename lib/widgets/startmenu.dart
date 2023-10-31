import 'package:flutter/material.dart';
import 'package:flutter_flame/state_and_api/scores_manager.dart';
import '/widgets/character_menu.dart';
import '/widgets/highscore_menu.dart';
import 'package:flutter_flame/cloud_chasers.dart';
import 'package:provider/provider.dart';
import 'dart:core';
import 'package:flutter_flame/widgets/buttons.dart';
import 'package:google_fonts/google_fonts.dart';

class Startmenu extends StatelessWidget {
  final VoidCallback onPlayButtonPressed;
  final CloudChasers game;

  Startmenu({super.key, required this.onPlayButtonPressed, required this.game});

  @override
  Widget build(BuildContext context) {
    ScoresManager scoresManager = context.read<ScoresManager>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: (DecorationImage(
            image: AssetImage("assets/images/background_glacial_mountains.png"),
            fit: BoxFit.cover,
          )),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Buttons.retroElevatedButton(
                onPressed: onPlayButtonPressed,
                label: 'Start Game',
              ),
              SizedBox(height: 35),
              Buttons.retroElevatedButton(
                onPressed: () async {
                  await scoresManager.updateLocalScores();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HighScoreMenu(game: game)),
                  );
                },
                label: 'Highscores',
              ),
              SizedBox(height: 35),
              Buttons.retroElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CharacterMenu()),
                  );
                },
                label: 'Select Character',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'Controls:\nTap to jump\nHold to double jump',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.pressStart2p(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
