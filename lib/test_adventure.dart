import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame/actors/player.dart';
import 'package:flutter_flame/state_and_api/scores_provider.dart';
import 'package:provider/provider.dart';
import 'levels/level.dart';
import 'package:flame/game.dart';
import 'widgets/game_over_screen.dart';

class TestAdventure extends FlameGame with TapCallbacks, HasCollisionDetection {
  late CameraComponent cam;
  final double gameWidth = 1080;
  final double gameHeight = 2400;
  int platformCount = 0;
  BuildContext? gameScreenContext;
  Map<String, int> playerScores = {};
  


  static final level = Level(levelName: "placeholder", player: Player(character: "Ninja Frog"));

  @override
  Color backgroundColor() => const Color(0xFF211F30);

  

  @override
  final world = level;

  void updatePlayerCharacter(String character) {
  final playerComponent = level.player;
  playerComponent.character = character;
  playerComponent.loadAnimations(character); // Load animations for the new character
}


  void incrementPlatformCount() {
    final scoresProvider = Provider.of<ScoresProvider>(gameScreenContext!, listen: false);
    scoresProvider.platformCount++;
  }

  int getPlatformScore() {
    final scoresProvider = Provider.of<ScoresProvider>(gameScreenContext!, listen: false);
    return platformCount = scoresProvider.platformCount;
  }


  void navigateBackToMainMenu() {
    if (gameScreenContext != null) {
      Navigator.of(gameScreenContext!).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              GameOverScreenOverlay(),
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

    final scoresProvider = Provider.of<ScoresProvider>(gameScreenContext!, listen: false);
  scoresProvider.addListener(() {
    final selectedCharacter = scoresProvider.selectedCharacter;
    updatePlayerCharacter(selectedCharacter);
  });

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    int platformCount = getPlatformScore();
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
