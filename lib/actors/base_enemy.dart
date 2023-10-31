import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame/actors/fast_enemy.dart';
import 'package:flutter_flame/actors/flipping_enemy.dart';
import 'package:flutter_flame/actors/platform.dart';
import 'package:flutter_flame/actors/player.dart';
import 'package:flutter_flame/actors/slow_enemy.dart';
import 'package:flutter_flame/actors/super_fast_enemy.dart';
import 'package:flutter_flame/actors/non_flipping_enemy.dart';
import 'package:flutter_flame/cloud_chasers.dart';

enum EnemyState { idle, running }

///Base class for enemies in the game.
class BaseEnemy extends SpriteAnimationGroupComponent
    with HasGameRef<CloudChasers>, CollisionCallbacks {
  late final hitbox = CircleHitbox(radius: 40, anchor: Anchor.topCenter)
    ..collisionType = CollisionType.passive;
  double velocityX;
  bool notFlipped = true;
  bool flipCooldown = true;
  String texturePath;
  Platform parentPlatform;
  BuildContext? gameScreenContext;

  BaseEnemy({
    Vector2? position,
    required this.velocityX,
    required this.texturePath,
    required this.parentPlatform,
  }) : super(
          position: position,
          size: Vector2(128, 128),
        ) {
    hitbox.position = size - Vector2(64, 100);
    add(hitbox);
  }

  /// Returns a random enemy type.
  /// if [emptyPlatform] = true the platform will be empty.
  /// [ypos] is the starting position.y value for the enemy.
  /// [parrentPlatform] is the platform where the enemy should be placed.
  static BaseEnemy createEnemy(
      {bool emptyPlatform = false,
      required double yPos,
      required Platform parentPlatform}) {
    int randomizer;
    if (emptyPlatform == true) {
      randomizer = 3;
    } else {
      randomizer = Random().nextInt(6);
    }

    Vector2 position = Vector2(Random().nextInt(800).toDouble(),
        yPos); //obs: om värdet 800 ökas så behöver flipEnemy-metoden justeras
    switch (randomizer) {
      case 0:
        return NonFlippingEnemy(
            position: position, parentPlatform: parentPlatform);
      case 1:
        return SuperFastEnemy(
            position: position, parentPlatform: parentPlatform);
      case 2:
        return FastEnemy(position: position, parentPlatform: parentPlatform);
      case 3:
        return FastEnemy(
            position: Vector2(1200, 3000),
            parentPlatform: parentPlatform); //spawnar tom plattform
      case 4:
        return SlowEnemy(position: position, parentPlatform: parentPlatform);
      case 5:
        return FlippingEnemy(
            position: position, parentPlatform: parentPlatform);
      default: // dart klagade på null om inget default
        throw UnimplementedError();
    }
  }

  @override
  Future<void> onLoad() async {
    loadAnimations();
    return super.onLoad();
  }

  void flipEnemyOnWallCollision() {
    if (((position.x > 200) && (position.x < 900)) && flipCooldown) {
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
      EnemyState.idle: assembleAnimation(texturePath, 10),
      EnemyState.running: assembleAnimation(texturePath, 10),
    };

    current = EnemyState.running;
  }

  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      CloudChasers.level.restartGame();
    }

    return super.onCollision(intersectionPoints, other);
  }
}
