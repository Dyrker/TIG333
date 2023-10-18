import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'test_adventure.dart';
import 'widgets/startmenu.dart';

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
        return GameScreen(game: game);
      },
    ),
  );
}

class GameScreen extends StatelessWidget {
  final TestAdventure game;

  GameScreen({required this.game});

  @override
  Widget build(BuildContext context) {
    game.gameScreenContext = context;
    return Scaffold(
      body: GameWidget(game: game),
      floatingActionButton: BackToStartMenuButton(),
    );
  }
}

class BackToStartMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pop(context); // Navigate back to the start menu.
      },
      child: Icon(Icons.arrow_back),
    );
  }
}
