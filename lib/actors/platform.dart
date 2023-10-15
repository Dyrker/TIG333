import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_flame/actors/platform_instances.dart';
import 'package:flutter_flame/actors/player.dart';
import 'package:flutter_flame/levels/level.dart';
import 'package:flutter_flame/test_adventure.dart';
import 'package:flutter_flame/actors/enemy.dart';

class Platform extends SpriteComponent with HasGameRef<TestAdventure>, CollisionCallbacks {
  final hitbox = RectangleHitbox()..collisionType = CollisionType.passive;

  Enemy? enemy;
  Platform({Vector2? position, this.enemy}) : super(position: position, size: Vector2(1080, 64));

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('Terrain/redplatform.png');
    add(hitbox);
    return super.onLoad();
  }

  static int platformVelocity = 500;
  static bool movementActivated = false;
  static bool isMovingOnScreen = false;
  static bool waitingForCollision = true;
  static bool waitingForPlatformToHitBottom = false;
  static bool platformHasTeleported = false;

  @override
  void update(double dt) {
    List platforms = [
      PlatformInstances.platform1.position.y,
      PlatformInstances.platform2.position.y,
      PlatformInstances.platform3.position.y,
      PlatformInstances.platform4.position.y,
      PlatformInstances.platform5.position.y,
    ];

    if (waitingForPlatformToHitBottom) {
      if (position.y > 2400) {
        double minValue = platforms.reduce((a, b) => a < b ? a : b);

        position.y = minValue - 480;
        waitingForPlatformToHitBottom = false;
        platformHasTeleported = true;
      }
      if (position.y >= 2326 && platformHasTeleported) {
        position.y = 2336;

        movementActivated = false;
        waitingForCollision = true;
        isMovingOnScreen = false;
        platformHasTeleported = false;
      }
    }

    if (movementActivated && !waitingForCollision) {
      position.y += dt * platformVelocity;
      isMovingOnScreen = true;
      waitingForPlatformToHitBottom = true;
    }

    if(enemy != null) {
  enemy!.position.y = position.y - enemy!.height;
  }
    super.update(dt);
  }

  static void startMovingPlatforms() {
    movementActivated = true;
  }

  static void collisionHappened() {
    if (movementActivated) {
      waitingForCollision = false;
    }
  }
}
