import 'package:flutter/material.dart';
import 'package:flutter_flame/test_adventure.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverScreenOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/staticBackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Back to main menu', style: GoogleFonts.pressStart2p()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}