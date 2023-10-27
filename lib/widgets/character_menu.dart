import 'package:flutter/material.dart';
import 'package:flutter_flame/state_and_api/character_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter_flame/widgets/buttons.dart';

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
            } else {
              characterManager.nextCharacter();
            }
          },
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background_glacial_mountains.png"),
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 145),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.arrow_back_ios, size: 40, color: Colors.white, shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 10.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )
                        ]),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 80,
                          height: 95,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/${characterManager.imageCharacter}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Icon(Icons.arrow_forward_ios, size: 40, color: Colors.white, shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 10.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )
                        ]),
                      ],
                    ),
                    SizedBox(height: 100),
                    Buttons.retroElevatedButton(
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
