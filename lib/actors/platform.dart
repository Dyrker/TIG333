import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_flame/actors/player.dart';
import 'package:flutter_flame/test_adventure.dart';
import 'package:flutter_flame/actors/base_enemy.dart';

class Platform extends SpriteComponent with HasGameRef<TestAdventure>, CollisionCallbacks {
  final hitbox = RectangleHitbox()..collisionType = CollisionType.passive;

  BaseEnemy? enemy;

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
  static int waitingInQueue = 0;

  late BaseEnemy childEnemy;

  @override
  void update(double dt) {
    List platforms = TestAdventure.level.platformInstances.getPlatforms();
    if (waitingForPlatformToHitBottom) {
      if (position.y > 2400) {
        Platform topPlatform = platforms.reduce((a, b) => a.position.y < b.position.y ? a : b);
        Platform bottomPlatform = platforms.reduce((a, b) => a.position.y > b.position.y ? a : b);
        position.y = topPlatform.position.y - 480;
        waitingForPlatformToHitBottom = false;
        platformHasTeleported = true;
        TestAdventure.level.removeEnemy(bottomPlatform.childEnemy);
        enemy =
            BaseEnemy.createEnemy(yPos: bottomPlatform.position.y, parentPlatform: bottomPlatform);
        TestAdventure.level.addEnemy(enemy);
        bottomPlatform.setChildEnemy(enemy);
      }
      if (position.y >= 2326 && platformHasTeleported) {
        position.y = 2336;
        movementActivated = false;
        waitingForCollision = true;
        isMovingOnScreen = false;
        platformHasTeleported = false;
        if (waitingInQueue > 0) {
          movementActivated = true;
          waitingInQueue -= 1;
        }
      }
    }

    if (movementActivated && !waitingForCollision) {
      position.y += dt * platformVelocity;
      isMovingOnScreen = true;
      waitingForPlatformToHitBottom = true;
    }

    if (enemy != null) {
      enemy!.position.y = position.y - enemy!.height;
    }
    super.update(dt);
  }

  static void prepareMovingPlatforms() {
    Player.setWaitingForScore(true);
    if (movementActivated) {
      waitingInQueue += 1;
    } else {
      movementActivated = true;
    }
  }

  static void collisionHappened() {
    if (movementActivated) {
      waitingForCollision = false;
    }
  }

  void setChildEnemy(enemy) {
    this.childEnemy = enemy;
  }

  static void resetStaticVariables() {
    platformVelocity = 500;
    movementActivated = false;
    isMovingOnScreen = false;
    waitingForCollision = true;
    waitingForPlatformToHitBottom = false;
    platformHasTeleported = false;
    waitingInQueue = 0;
  }
}
