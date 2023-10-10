import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter_flame/actors/player.dart';
import 'package:flutter_flame/levels/background.dart';
import 'package:flutter_flame/test_adventure.dart';
import "package:flutter_flame/actors/platform.dart";

class Level extends World with HasGameRef<TestAdventure>{
  late TiledComponent level;
  final String levelName;


  Player player;

  Level({required this.levelName, required this.player});

  @override
  FutureOr<void> onLoad() async {
    StaticBackground level = StaticBackground(Vector2(gameRef.gameWidth,gameRef.gameHeight));

    addAll([level, player, Platform(position: Vector2(0,1200))]);

    return super.onLoad();
  }
}
