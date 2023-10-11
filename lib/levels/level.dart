// level.dart

import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter_flame/actors/player.dart';
import 'package:flutter_flame/levels/background.dart';
import 'package:flutter_flame/test_adventure.dart';

class Level extends World with HasGameRef<TestAdventure>, TapCallbacks {
  late TiledComponent level;
  final String levelName;

  Player player;

  bool longTapDetected = false; // Define the variable here

  @override
  void onTapDown(TapDownEvent event) {
    // Check if it's a short tap (not a long tap)
    if (!longTapDetected) {
      player.startJump();
    }
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    // Set the long tap state
    longTapDetected = true;
    player.longJump();
  }

  // Add onTapUp to reset the longTapDetected state
  @override
  void onTapUp(TapUpEvent event) {
    longTapDetected = false;
  }

  Level({required this.levelName, required this.player});

  @override
  FutureOr<void> onLoad() async {
    StaticBackground level =
        StaticBackground(Vector2(gameRef.gameWidth, gameRef.gameHeight));

    addAll([level, player]);

    return super.onLoad();
  }
}
