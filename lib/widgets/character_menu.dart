import 'package:flutter/material.dart';
import 'package:flutter_flame/state_and_api/character_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CharacterMenu extends StatelessWidget {
  CharacterMenu({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterManager>(builder: (context, characterManager, child) {
      String characterimg = characterManager.imageCharacter;
      return MaterialApp(
        home: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/staticBackground.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: 50, // Adjust the size as needed
                        height: 50, // Adjust the size as needed
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/$characterimg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            String selectedCharacter = "Pink Man";
                            characterManager.setSelectedCharacter(selectedCharacter);
                            characterManager.setImageCharacter("Pinkman.png");
                          },
                          child: Text(
                            ('Pink Man'),
                            style: GoogleFonts.pressStart2p(),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            String selectedCharacter = "Ninja Frog";
                            characterManager.setSelectedCharacter(selectedCharacter);
                            characterManager.setImageCharacter("Ninjafrog.png");
                          },
                          child: Text(
                            ('Ninja Frog'),
                            style: GoogleFonts.pressStart2p(),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            String selectedCharacter = "Virtual Guy";
                            characterManager.setSelectedCharacter(selectedCharacter);
                            characterManager.setImageCharacter("Virtualguy.png");
                          },
                          child: Text(
                            ('Virtual Guy'),
                            style: GoogleFonts.pressStart2p(),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            String selectedCharacter = "Mask Dude";
                            characterManager.setSelectedCharacter(selectedCharacter);
                            characterManager.setImageCharacter("Maskeddude.png");
                          },
                          child: Text(
                            ('Mask Dude'),
                            style: GoogleFonts.pressStart2p(),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            String selectedCharacter = "Purple Man";
                            characterManager.setSelectedCharacter(selectedCharacter);
                            characterManager.setImageCharacter("Purpleman.png");
                          },
                          child: Text(
                            ('Purple Man'),
                            style: GoogleFonts.pressStart2p(),
                          ),
                        )
                      ]),
                    ),
                    IntrinsicWidth(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          ('Return to menu'),
                          style: GoogleFonts.pressStart2p(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
