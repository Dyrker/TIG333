import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_flame/actors/base_enemy.dart';
import 'package:flutter_flame/actors/platform_instances.dart';
import 'package:flutter_flame/actors/player.dart';
import 'package:flutter_flame/levels/background.dart';
import 'package:flutter_flame/test_adventure.dart';

class Level extends World with HasGameRef<TestAdventure>, TapCallbacks {
  final String levelName;
  Player player;
  bool jumpingDisabled = false;

  Level({required this.levelName, required this.player});

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

  @override
  FutureOr<void> onLoad() async {
    StaticBackground level = StaticBackground(Vector2(gameRef.gameWidth, gameRef.gameHeight));

    addAll([level, player]);

    PlatformInstances.initialize();
    List platforms = PlatformInstances.getPlatforms();
    for (var platform in platforms) {
      add(platform);
      BaseEnemy enemy =
          BaseEnemy.createEnemy(yPos: platform.position.y - 128, parentPlatform: platform);
      add(enemy);
      platform.childEnemy = enemy;
    }

    return super.onLoad();
  }

  void removeEnemy(enemy) {
    remove(enemy);
  }

  void addEnemy(enemy) {
    add(enemy);
  }
}
