import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter_flame/test_adventure.dart';

enum PlayerState { idle, running }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<TestAdventure> {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime = 0.05;
  double speed = 100;
  
  String character;
  Player({position, required this.character}) : super(position: position);

  @override
  FutureOr<void> onLoad() {
    loadAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x += speed * dt;

    if (position.x < 0 || position.x + width > gameRef.gameWidth) {
      flipHorizontally();
      speed = -speed;
      position.x += speed * dt;
    }

  }

  void loadAnimations() {
    SpriteAnimation assembleAnimation(String location, int amount) {
      return SpriteAnimation.fromFrameData(
          game.images.fromCache(location),
          SpriteAnimationData.sequenced(
            amount: amount,
            stepTime: stepTime,
            textureSize: Vector2.all(128),
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