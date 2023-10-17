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
      home: Startmenu(
        onPlayButtonPressed: () {
          startGame(game);
        },
        game: game,
      ),
    ),
  );
}

void startGame(TestAdventure game) {
  runApp(GameWidget(game: game));
}
