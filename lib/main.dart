import "package:flame/flame.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flame/game.dart";
import "test_adventure.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setPortrait();

  TestAdventure game = TestAdventure();
  runApp(GameWidget(game: kDebugMode ? TestAdventure() : game));
}
