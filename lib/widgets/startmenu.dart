import 'package:flutter/material.dart';
import 'package:flutter_flame/state_and_api/character_manager.dart';
import 'package:flutter_flame/state_and_api/scores_manager.dart';
import '/widgets/Character_menu.dart';
import '/widgets/Highscore_menu.dart';
import 'package:flutter_flame/test_adventure.dart';
import 'package:provider/provider.dart';
import 'dart:core';
import 'package:flutter_flame/widgets/jumper_menu_buttons.dart'; 

class Startmenu extends StatelessWidget {
  final VoidCallback onPlayButtonPressed;
  final TestAdventure game;

  Startmenu({super.key, required this.onPlayButtonPressed, required this.game});

  @override
  Widget build(BuildContext context) {
    ScoresManager scoresManager = context.read<ScoresManager>();
    return MaterialApp(
      home: Scaffold(
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
                ButtonStyles.retroElevatedButton( 
                  onPressed: onPlayButtonPressed,
                  label: 'Start Game',
                ),
                SizedBox(height: 20),
                ButtonStyles.retroElevatedButton( 
                  onPressed: () async {
                    await scoresManager.updateLocalScores();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HighScoreMenu(game: game)),
                    );
                  },
                  label: 'Highscores',
                ),
                SizedBox(height: 20),
                ButtonStyles.retroElevatedButton( 
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CharacterMenu()),
                    );
                  },
                  label: 'Select Character',
                ),
                SizedBox(height: 20),
                ButtonStyles.retroElevatedButton( 
                  onPressed: onPlayButtonPressed,
                  label: 'Options',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
