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

  bool jumpingDisabled = false;

  @override
  void onTapDown(TapDownEvent event) {
    if (player.jumpState == JumpState.idle) {
      player.jumpHandler();
    }
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    if (player.jumpState == JumpState.shortJump) {
      player.jumpHandler();
    }
  }

  void onTapUp(TapUpEvent event) {
    player.jumpingDisabled = true;
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
      if (platform.enemy != null) {
        add(platform.enemy!);
      }
    }

    return super.onLoad();
  }
}
