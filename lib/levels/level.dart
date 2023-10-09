import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter_flame/actors/player.dart';
import 'package:flutter_flame/levels/background.dart';

class Level extends World {
  late TiledComponent level;
  final String levelName;

  Level({required this.levelName});

  @override
  FutureOr<void> onLoad() async {
    StaticBackground level = StaticBackground(Vector2.all(1000));

    addAll([level, Player(character: "Ninja Frog")]);

    return super.onLoad();
  }
}
