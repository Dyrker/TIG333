import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter_flame/actors/player.dart';
import 'package:flutter_flame/levels/background.dart';

class Level extends World{
  late TiledComponent level;
  final String levelName;
  final double _width = 500;
  final double _height = 1000;

  Player player;

  Level({required this.levelName, required this.player});

  @override
  FutureOr<void> onLoad() async {
    StaticBackground level = StaticBackground(Vector2(_width,_height));

    addAll([level, player]);

    return super.onLoad();
  }
}
