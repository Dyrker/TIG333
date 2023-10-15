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

  runApp(const MaterialApp(
    home: Startmenu(onPlayButtonPressed: startGame),
  ));
}

void startGame() {
  runApp(GameWidget(game: kDebugMode ? TestAdventure() : TestAdventure()));
}
