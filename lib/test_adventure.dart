import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame/actors/player.dart';
import 'levels/level.dart';
import 'package:flame/game.dart';
import 'main.dart';

class TestAdventure extends FlameGame with TapCallbacks, HasCollisionDetection {
  late CameraComponent cam;
  final double gameWidth = 1080;
  final double gameHeight = 2400;
  int platformCount = 20;
  
  static final level = Level(levelName: "placeholder", player: Player(character: "Ninja Frog"));

  @override
  Color backgroundColor() => const Color(0xFF211F30);

  @override
  final world = level;

  void incrementPlatformCount() {
    platformCount++;
  }

  int getPlatformCount() {
    return platformCount;
  }

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(world: world, width: gameWidth, height: gameHeight);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);

    return super.onLoad();
  }
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Step 3: Render the score on the screen
    final TextPainter painter = TextPainter(
      text: TextSpan(
        text: 'Score: $platformCount',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    painter.layout();
    painter.paint(canvas, Offset(900, 0)); // Adjust the position as needed.
  }

}

