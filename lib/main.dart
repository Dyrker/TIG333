import "package:flame/flame.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flame/game.dart";
import "test_adventure.dart";
import "startmenu.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setPortrait();

  final TestAdventure game = kDebugMode ? TestAdventure() : TestAdventure();

  runApp(
    MaterialApp(
      home: Builder(
        builder: (context) {
          return Startmenu(
            onPlayButtonPressed: () {
              startGame(context, game);
            },
            game: game,
          );
        },
      ),
    ),
  );
}

void startGame(BuildContext context, TestAdventure game) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Your Game Title'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); 
              },
            ),
          ),
          body: GameWidget(game: game),
        );
      },
    ),
  );
}

