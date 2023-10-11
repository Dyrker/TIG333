import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter_flame/actors/player.dart';
import 'package:flutter_flame/levels/background.dart';
import 'package:flutter_flame/test_adventure.dart';
import "package:flutter_flame/actors/platform.dart";

class Level extends World with HasGameRef<TestAdventure> {
  late TiledComponent level;
  final String levelName;
  final int numberOfPlatforms = 5;

  Player player;

  Level({required this.levelName, required this.player});

  @override
  FutureOr<void> onLoad() async {
    StaticBackground level =
        StaticBackground(Vector2(gameRef.gameWidth, gameRef.gameHeight));

    addAll([level, player]);

    for (double i = 1; i <= numberOfPlatforms; i++) {
      add(createPlatforms(i * 0, ((i * gameRef.gameHeight/numberOfPlatforms) - 128) ));
    }
    return super.onLoad();
  }

  Platform createPlatforms(double x, double y) {
    return Platform(position: Vector2(x, y));
  }
}
