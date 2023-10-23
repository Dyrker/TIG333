import 'package:flutter/material.dart';
import 'package:flutter_flame/state_and_api/character_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter_flame/widgets/jumper_menu_buttons.dart';

class CharacterMenu extends StatelessWidget {
  CharacterMenu({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterManager>(
        builder: (context, characterManager, child) {
      return Scaffold(
        body: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              characterManager.previousCharacter();
              print(
                  'Selected Character: ${characterManager.selectedCharacter}');
            } else {
              characterManager.nextCharacter();
              print(
                  'Selected Character: ${characterManager.selectedCharacter}');
            }
          },
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/staticBackground.jpg"),
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter),
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
                        Container(
                          width: 100,
                          height: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/${characterManager.imageCharacter}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                          height: 10,
                        ),
                        Icon(
                          Icons.arrow_forward_ios, // right arrow
                          size: 40,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 100),
                    ButtonStyles.retroElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      label: 'Return to menu',
                      fontSize: 16.0,
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
