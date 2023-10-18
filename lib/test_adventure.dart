import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame/actors/player.dart';
import 'levels/level.dart';
import 'package:flame/game.dart';
import 'widgets/game_over_screen.dart';

class TestAdventure extends FlameGame with TapCallbacks, HasCollisionDetection {
  late CameraComponent cam;
  final double gameWidth = 1080;
  final double gameHeight = 2400;
  int platformCount = 20;
  BuildContext? gameScreenContext;

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

  void navigateBackToMainMenu() {
    if (gameScreenContext != null) {
      Navigator.of(gameScreenContext!).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              GameOverScreenOverlay(), // Replace with the actual game over screen widget
        ),
      );
    }
  }

  void goToStartMenu(BuildContext context) {
    Navigator.of(context).pop();
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
    painter.paint(canvas, Offset(900, 0));
  }
}
