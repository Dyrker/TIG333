import 'package:flutter/material.dart';
import 'package:flutter_flame/state_and_api/character_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CharacterMenu extends StatelessWidget {
  CharacterMenu({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterManager>(builder: (context, characterManager, child) {

      return Scaffold(
        body: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              characterManager.previousCharacter();
              print('Selected Character: ${characterManager.selectedCharacter}');
            } else {
              characterManager.nextCharacter();
              print('Selected Character: ${characterManager.selectedCharacter}');
            }
          },
          child: Stack(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios, // left arrow
                          size: 40,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: 100, 
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/${characterManager.imageCharacter}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 20, height: 10,),
                        Icon(
                          Icons.arrow_forward_ios, // right arrow
                          size: 40,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        ('Return to menu'),
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
    });
  }
}
