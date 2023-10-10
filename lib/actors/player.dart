import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_flame/test_adventure.dart';

enum PlayerState { idle, running }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<TestAdventure>, TapCallbacks {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime = 0.05;
  double speed = 300;

  String character;
  Player({position, required this.character})
      : super(position: position, size: Vector2(128, 128));

  @override
  FutureOr<void> onLoad() {
    loadAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x += speed * dt;

    if (position.x < 0 || position.x + size.x > gameRef.gameWidth) {
      flipHorizontally();
      speed = -speed;
      position.x += speed * dt;
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    // Handle tap action here
    // You can add player actions or trigger events when the screen is tapped
    speed = -speed;
  }

  void loadAnimations() {
    SpriteAnimation assembleAnimation(String location, int amount) {
      return SpriteAnimation.fromFrameData(
          game.images.fromCache(location),
          SpriteAnimationData.sequenced(
            amount: amount,
            stepTime: stepTime,
            textureSize: Vector2.all(32),
          ));
    }

    animations = {
      PlayerState.idle:
          assembleAnimation("Main Characters/$character/Idle (32x32).png", 11),
      PlayerState.running:
          assembleAnimation("Main Characters/$character/Run (32x32).png", 12),
    };

    current = PlayerState.idle;
  }
}
