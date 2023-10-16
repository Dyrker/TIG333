import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'test_adventure.dart';

class CharacterMenu extends StatelessWidget {// Callback for the button press

  const CharacterMenu({super.key});

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
                onPressed: () {}, 
                child: Text(('Please Select Character'), style: GoogleFonts.pressStart2p()),
                ),
              ElevatedButton(
                onPressed: () {Navigator.of(context).pop();}, 
                child: Text(('Return to Menu (PlaceHolder)'), style: GoogleFonts.pressStart2p()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
