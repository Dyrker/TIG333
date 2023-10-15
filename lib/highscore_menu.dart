import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HighScoreMenu extends StatelessWidget { // Callback for the button press

  const HighScoreMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        body: Container(
          decoration: const BoxDecoration(
                      image: (DecorationImage(image: AssetImage("assets/images/staticBackground.jpg"),
                      fit: BoxFit.cover))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            ],
          ),
        ),
      );
  }
}
