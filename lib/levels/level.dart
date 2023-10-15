// level.dart

import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter_flame/actors/platform_instances.dart';
import 'package:flutter_flame/actors/player.dart';
import 'package:flutter_flame/levels/background.dart';
import 'package:flutter_flame/test_adventure.dart';
import "package:flutter_flame/actors/platform.dart";
import 'package:flutter_flame/actors/enemy.dart';

class Level extends World with HasGameRef<TestAdventure>, TapCallbacks {
  late TiledComponent level;
  final String levelName;
  final int numberOfPlatforms = 5;

  Player player;

  Enemy enemy;

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
    Platform.startMovingPlatforms();
  }

  // Add onTapUp to reset the longTapDetected state
  @override
  void onTapUp(TapUpEvent event) {
    longTapDetected = false;
  }

  Level({required this.levelName, required this.player, required this.enemy});

  @override
  FutureOr<void> onLoad() async {
    StaticBackground level = StaticBackground(Vector2(gameRef.gameWidth, gameRef.gameHeight));

    addAll([level, player]);

    PlatformInstances platformManager = PlatformInstances.initialize();
    List platformList = platformManager.getPlatforms();
    for (var platform in platformList) {
      add(platform);
      if(platform.enemy != null) {
        add(platform.enemy!);
      }
    }

    return super.onLoad();
  }
}
