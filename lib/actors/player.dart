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
  double jumpVelocity = -700;
  double longJumpVelocity = -600;
  double gravity = 20;
  double jumpStartingPosition = 0;
  bool isLongJump = false;
  bool isjumping = false; //används ej atm.
  bool notFlipped = true;
  bool flipCooldown = true;

  String character;

  Player({position, required this.character}) : super(position: position, size: Vector2(128, 128)) {
    add(hitbox);
  }

  @override
  FutureOr<void> onLoad() {
    loadAnimations();
    position.y = gameRef.gameHeight - Platform().size.y - size.y;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (dt > 0.05) return;

    flipPlayerOnWallCollision();
    
    velocityY += gravity;
    position.x += velocityX * dt;
    position.y += velocityY * dt;
    
    if (Platform.isMovingOnScreen) {
      position.y += dt * Platform.platformVelocity;
    }
    super.update(dt);
  }

  void flipPlayerOnWallCollision() {
    if (((position.x > 300) && (position.x < 700)) && flipCooldown) {
      flipCooldown = false;
    }
    
    if ((position.x < 128 || position.x + size.x > gameRef.gameWidth) && !flipCooldown) {
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
  }

  void startJump() {

    if (velocityY != 0 && velocityY != 20) {
      return;
    }

    jumpStartingPosition = position.y;
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
      PlayerState.idle: assembleAnimation("Main Characters/$character/Idle (32x32).png", 11),
      PlayerState.running: assembleAnimation("Main Characters/$character/Run (32x32).png", 12),
    };

    current = PlayerState.idle;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (velocityY < 0) {
      return;
    }

    final isTopCollision = isTopCollisionWithPlatform(intersectionPoints);

    if (other is Platform) {
      if (isTopCollision) {
        platformIntersectionCheck(intersectionPoints);
        velocityY = 0;
        
        Platform.collisionHappened();
      }
    }
    
    super.onCollision(intersectionPoints, other);
  }

  bool isTopCollisionWithPlatform(Set<Vector2> intersectionPoints) {
    final characterCenter = Vector2(position.x + size.x / 2, position.y + size.y / 2);

    final averageIntersectionPoint = intersectionPoints.reduce((a, b) => a + b) / 2;

    return characterCenter.y < averageIntersectionPoint.y;
  }

  void platformIntersectionCheck(Set<Vector2> intersectionPoints) {
    final Vector2 mid = (intersectionPoints.elementAt(0) + intersectionPoints.elementAt(1)) / 2;

    final Vector2 collisionNormal = absoluteCenter - mid;
    double penetrationlength = (size.x / 2) - collisionNormal.length;
    collisionNormal.normalize();

    position += collisionNormal.scaled(penetrationlength);
  }
}
