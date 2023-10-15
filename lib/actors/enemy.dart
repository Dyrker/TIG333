import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_flame/actors/player.dart';
import 'package:flutter_flame/test_adventure.dart';

enum EnemyState { idle, running }

class Enemy extends SpriteAnimationGroupComponent
    with HasGameRef<TestAdventure>, CollisionCallbacks {
  late final hitbox = CircleHitbox()..collisionType = CollisionType.passive;
  double velocityX = 400;
  bool notFlipped = true;
  bool flipCooldown = true;

  Enemy({Vector2? position}): super(position: position, size: Vector2(128, 128),) {
    add(hitbox);
  }

  @override
  FutureOr<void> onLoad() async {
    loadAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    flipEnemyOnWallCollision();
    position.x += velocityX * dt;
    super.update(dt);
  }

  void flipEnemyOnWallCollision() {
    if (((position.x > 300) && (position.x < 700)) && flipCooldown) {
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
  }

  void loadAnimations() {
    SpriteAnimation assembleAnimation(String location, int amount) {
      return SpriteAnimation.fromFrameData(
          game.images.fromCache(location),
          SpriteAnimationData.sequenced(
            amount: amount,
            stepTime: 0.05,
            textureSize: Vector2.all(32),
          ));
    }

    animations = {
      EnemyState.idle:
          assembleAnimation("Main Characters/Mask Dude/Idle (32x32).png", 10),
      EnemyState.running:
          assembleAnimation("Main Characters/Mask Dude/Run (32x32).png", 10),
    };

    current = EnemyState.running;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
   if (other is Player) {
    print('Aj');
   }
  }
}
