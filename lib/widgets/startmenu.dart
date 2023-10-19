import 'package:flutter/material.dart';
import 'package:flutter_flame/state_and_api/scores_api.dart';
import '/widgets/Character_menu.dart';
import '/widgets/Highscore_menu.dart';
import 'package:flutter_flame/test_adventure.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../state_and_api/scores_provider.dart';
import 'dart:core';

class Startmenu extends StatelessWidget {
  final VoidCallback onPlayButtonPressed;
  final TestAdventure game;

  Startmenu({super.key, required this.onPlayButtonPressed, required this.game});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: (DecorationImage(
                image: AssetImage("assets/images/background_glacial_mountains.png"),
                fit: BoxFit.cover))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: onPlayButtonPressed,
                  child: Text(('Start Game'), style: GoogleFonts.pressStart2p())),
              SizedBox(height: 20),
              ElevatedButton(
                  child: Text(('Highscores'), style: GoogleFonts.pressStart2p()),
                  onPressed: () async {
                    final highScoreApi = context.read<ApiUserScore>();
                    await highScoreApi.removeApiScoresBelowTop();
                    highScoreApi.fetchScores().then((_) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HighScoreMenu(game: game)));});

                        
                  }),
              SizedBox(height: 20),
              ElevatedButton(
                  child: Text(('Select Character'), style: GoogleFonts.pressStart2p()),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => CharacterMenu()));
                  }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: onPlayButtonPressed,
                child: Text(('Options'), style: GoogleFonts.pressStart2p()),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
