// player.dart

import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_flame/test_adventure.dart';
import "package:flutter_flame/actors/platform.dart";

enum PlayerState { idle, running }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<TestAdventure>, CollisionCallbacks {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime = 0.05;
  final hitbox = CircleHitbox()..collisionType = CollisionType.active;
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
  bool allowJump = true;

  String character;

  Player({position, required this.character}) : super(position: position, size: Vector2(128, 128)){add(hitbox);}
  
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
      velocityY = velocityY.clamp(jumpVelocity, 1500);
    } else if (currentJumpPos <= maxLongJump && isLongJump) {
      velocityY += gravity;
      velocityY = velocityY.clamp(longJumpVelocity, 1500);
    }

    

    position.x += velocityX * dt;


    position.y += velocityY * dt;
  }

  void startJump() {
    print(velocityY);
    
    if (!allowJump){
      return;
    }
    allowJump = false;
    isLongJump = false;
    velocityY = isLongJump ? longJumpVelocity : jumpVelocity;
  }

  void longJump() {

    allowJump = false;
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

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other){
    if (velocityY < 0){
      return;
    }
    super.onCollision(intersectionPoints, other);
    allowJump = true;
    if (other is Platform){
      if(intersectionPoints.length == 2){
        platformIntersectionCheck(intersectionPoints);
      }
    }
  }

  void platformIntersectionCheck(Set<Vector2> intersectionPoints){
    final Vector2 mid = (intersectionPoints.elementAt(0) + intersectionPoints.elementAt(1)) / 2;

    final Vector2 collisionNormal = absoluteCenter - mid;
    double penetrationlength = (size.x / 2) - collisionNormal.length;
    collisionNormal.normalize();

    position += collisionNormal.scaled(penetrationlength);
    
  }

}
