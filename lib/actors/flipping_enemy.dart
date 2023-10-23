import 'package:flutter_flame/actors/fast_enemy.dart';
import 'package:flutter_flame/actors/platform.dart';
import 'package:flutter_flame/test_adventure.dart';

import 'base_enemy.dart';
import 'package:flame/components.dart';

class FlippingEnemy extends BaseEnemy {
  bool notFlippedOnJump = true;
  bool flipOnJumpCooldown = true;
  double dtTimer = 0;
  FlippingEnemy({Vector2? position, required Platform parentPlatform})
      : super(
          position: position,
          velocityX: 200,
          texturePath: "Main Characters/Virtual Guy/Run (32x32).png",
          parentPlatform: parentPlatform,
        );

  @override
  void update(double dt) {
    if (dt > 0.05) return;
    super.update(dt); // Call the base class's update method
    Vector2 playerPos = TestAdventure.level.player.position;
    position.y = parentPlatform.position.y - 128;
    dtTimer += dt;
    flipOnPlayerJump(playerPos);
    // Custom update logic specific to the FastEnemy class
    flipEnemyOnWallCollision();
    position.x += velocityX * dt;
  }

  void flipOnPlayerJump(Vector2 playerPos){
    
    if ((dtTimer > 0.25 ) && ((position.x >= playerPos.x && position.x <= playerPos.x + 10)) && (playerPos.y <= position.y - 10) && (playerPos.y > position.y - 400)) {
      print("here");
      if (notFlipped) {
        position.x += 128;
        notFlipped = false;
      } else {
        position.x -= 128;
        notFlipped = true;
      }
      flipHorizontally();
      velocityX = -velocityX;
      dtTimer = 0;
    }

  }
}
