import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter_flame/test_adventure.dart';

enum PlayerState { idle, running }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<TestAdventure> {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime = 0.05;
  double velocityX = 300;
  double velocityY = 100;
  bool isjumping = false;
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

    position.x += velocityX * dt;

    if (position.x < 0 || position.x + size.x > gameRef.gameWidth) {
      flipHorizontally();
      velocityX = -velocityX;
      position.x += velocityX * dt;
    }
    if (isjumping) {
      position.y += -velocityY * dt;
    } else {
      position.y += velocityY * dt;
    }
  }

  void togglejump() {
    isjumping = !isjumping;
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
