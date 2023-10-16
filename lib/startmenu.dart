import 'package:flutter/material.dart';
import 'package:flutter_flame/Character_menu.dart';
import 'package:flutter_flame/Highscore_menu.dart';
import 'package:google_fonts/google_fonts.dart';

class Startmenu extends StatelessWidget {
  final VoidCallback onPlayButtonPressed; // Callback for the button press

  const Startmenu({super.key, required this.onPlayButtonPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
                      image: (DecorationImage(image: AssetImage("assets/images/staticBackground.jpg"),
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
                onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HighScoreMenu()));}),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(('Select Character'), style: GoogleFonts.pressStart2p()),
                onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CharacterMenu()));}),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: onPlayButtonPressed, 
                child: Text(('Options'), style: GoogleFonts.pressStart2p()),
              ),
            ],
          ),
        ),
      ),
    )
  );
  }
}
