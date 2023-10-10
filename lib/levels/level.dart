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
  @override
  void onTapUp(TapUpEvent event) {
    player.startJump(true);
    // Handle tap action here
    // You can add player actions or trigger events when the screen is tapped
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    player.startJump(false);
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
