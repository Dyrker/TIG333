// player.dart

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
  double velocityY = 0;
  double jumpVelocity = -1200;
  double longJumpVelocity = -1600;
  double gravity = 50;
  double maxJumpPosY = 1200;
  double maxLongJump = 1600;
  double currentJumpPos = 0.0;
  bool isLongJump = false;
  bool isjumping = false; //används ej atm.
  bool notFlipped = true;
  bool flipCooldown = true;

  String character;
  Player({position, required this.character})
      : super(position: position, size: Vector2(128, 128));

  @override
  FutureOr<void> onLoad() {
    loadAnimations();
    position.y = 1200;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    currentJumpPos = position.y;
    if ((position.x > 540) && (position.x < 550)) {
      flipCooldown = false;
    }

    if ((position.x < 128 || position.x + size.x > gameRef.gameWidth) &&
        !flipCooldown) {
      if (notFlipped) {
        position.x += 128;
        notFlipped = false;
      } else {
        position.x -= 128;
        notFlipped = true;
      }

      flipHorizontally();
      velocityX = -velocityX;
      flipCooldown = true;
    }

    if (currentJumpPos <= maxJumpPosY && !isLongJump) {
      velocityY += gravity;
    } else if (currentJumpPos <= maxLongJump && isLongJump) {
      velocityY += gravity;
    }

    print(position.y);

    position.x += velocityX * dt;

    if (position.y > 1200) {
      velocityY = 0;
    }

    position.y += velocityY * dt;
  }

  void startJump() {
    if (velocityY != 0) {
      return;
    }
    position.y = 1195;
    isLongJump = false;
    velocityY = isLongJump ? longJumpVelocity : jumpVelocity;
  }

  void longJump() {
    isLongJump = true;
    velocityY += longJumpVelocity;
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
