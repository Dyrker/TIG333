import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_flame/test_adventure.dart';
import "package:flutter_flame/actors/platform.dart";

enum RunningState { idle, running }

enum JumpState { idle, shortJump, longJump }

///The player controlled character.
class Player extends SpriteAnimationGroupComponent
    with HasGameRef<TestAdventure>, CollisionCallbacks {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  late final SpriteAnimation doubleJumpAnimation;
  late final SpriteAnimation jumpAnimation;
  final double stepTime = 0.05;
  final hitbox = CircleHitbox(radius: 50, anchor: Anchor.topCenter)
    ..collisionType = CollisionType.active;
  double velocityX = 450;
  double velocityY = 0;
  double gravity = 30;
  bool notFlipped = true;
  bool flipCooldown = true;
  JumpState jumpState = JumpState.idle;
  bool jumpingDisabled = false;
  static bool waitingForScore = false;
  String character;

  Player({position, required this.character}) : super(position: position, size: Vector2(128, 128)) {
    hitbox.position = size - Vector2(64, 100);
    add(hitbox);
  }

  void jumpHandler() {
    if (jumpingDisabled) {
      return;
    }
    switch (jumpState) {
      case JumpState.idle:
        jumpState = JumpState.shortJump;
        position.y += 10;
        resetVelocity();
        velocityY -= 750;
      case JumpState.shortJump:
        jumpState = JumpState.longJump;
        resetVelocity();
        velocityY -= 1150;
        Platform.prepareMovingPlatforms();
      case JumpState.longJump:
        return;
    }
  }

  void resetVelocity() {
    velocityY = 0;
  }

  void resetJumpState() {
    jumpState = JumpState.idle;
  }

  @override
  FutureOr<void> onLoad() {
    loadAnimations(character);
    position.y = gameRef.gameHeight - Platform().size.y - size.y;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (dt > 0.05) return;

    flipPlayerOnWallCollision();

    if (jumpState != JumpState.idle) {
      velocityY += gravity;
      switch (jumpState) {
        case JumpState.shortJump:
          current = JumpState.shortJump;
          break;
        case JumpState.longJump:
          current = JumpState.longJump;
          break;
        default:
          current = RunningState.running;
          break;
      }
    } else {
      current = RunningState.running;
    }
    position.x += velocityX * dt;
    position.y += velocityY * dt;

    if (Platform.isMovingOnScreen) {
      position.y += dt * Platform.platformVelocity;
    }
    super.update(dt);
  }

  void flipPlayerOnWallCollision() {
    if (((position.x > 200) && (position.x < 900)) && flipCooldown) {
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

  void loadAnimations(String character) {
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
      RunningState.idle: assembleAnimation("Main Characters/$character/Idle (32x32).png", 11),
      RunningState.running: assembleAnimation("Main Characters/$character/Run (32x32).png", 12),
      JumpState.shortJump: assembleAnimation("Main Characters/$character/Jump (32x32).png", 1),
      JumpState.longJump:
          assembleAnimation("Main Characters/$character/Double Jump (32x32).png", 6),
    };

    current = RunningState.running;
  }

  static void setWaitingForScore(bool choice) {
    waitingForScore = choice;
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

        resetJumpState();
        jumpingDisabled = false;
        Platform.collisionHappened();
        if (waitingForScore) {
          game.incrementPlatformCount();
          setWaitingForScore(false);
        }
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
