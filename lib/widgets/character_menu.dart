import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_flame/state_and_api/scores_provider.dart';
import 'package:provider/provider.dart';


class CharacterMenu extends StatelessWidget {
  
  CharacterMenu({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScoresProvider>(
      builder: (context, scoresProvider, child) {
        String characterimg = scoresProvider.imageCharacter;
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
                  Container(
                    width: 200, // Adjust the size as needed
                    height: 200, // Adjust the size as needed
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/$characterimg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  ElevatedButton(
                    onPressed: () {String selectedCharacter = "Pink Man";
                    scoresProvider.setSelectedCharacter(selectedCharacter);
                    scoresProvider.setImageCharacter("Pinkman.png");
                    },
                    child: Text(
                      ('Pink Man'),
                      style: GoogleFonts.pressStart2p(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {String selectedCharacter = "Ninja Frog";
                    scoresProvider.setSelectedCharacter(selectedCharacter);
                    scoresProvider.setImageCharacter("Ninjafrog.png");
                    },
                    child: Text(
                      ('Ninja Frog'),
                      style: GoogleFonts.pressStart2p(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {String selectedCharacter = "Virtual Guy";
                    scoresProvider.setSelectedCharacter(selectedCharacter);
                    scoresProvider.setImageCharacter("Virtualguy.png");
                    },
                    child: Text(
                      ('Virtual Guy'),
                      style: GoogleFonts.pressStart2p(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {String selectedCharacter = "Mask Dude";
                    scoresProvider.setSelectedCharacter(selectedCharacter);
                    scoresProvider.setImageCharacter("Maskeddude.png");
                    },
                    child: Text(
                      ('Mask Dude'),
                      style: GoogleFonts.pressStart2p(),
                    ),
                    
                  ),
                  ElevatedButton(
                    onPressed: () {String selectedCharacter = "Purple Man";
                    scoresProvider.setSelectedCharacter(selectedCharacter);
                    scoresProvider.setImageCharacter("Purpleman.png");
                    },
                    child: Text(
                      ('Mask Dude'),
                      style: GoogleFonts.pressStart2p(),
                    ),
                    
                  )
                  ]),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      ('Return to Menu (PlaceHolder)'),
                      style: GoogleFonts.pressStart2p(),
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
    }
    );
  }
}