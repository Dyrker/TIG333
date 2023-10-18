import 'package:flutter_flame/actors/platform.dart';

import 'base_enemy.dart';
import 'package:flame/components.dart';

class SuperFastEnemy extends BaseEnemy {
  SuperFastEnemy({Vector2? position, required Platform parentPlatform})
      : super(
          position: position,
          velocityX: 500,
          texturePath: "Main Characters/Purple Man/Run (32x32).png",
          parentPlatform: parentPlatform,
        );

  @override
  void update(double dt) {
    super.update(dt); // Call the base class's update method

    position.y = parentPlatform.position.y - 128;

    // Custom update logic specific to the FastEnemy class
    flipEnemyOnWallCollision();
    position.x += velocityX * dt;
  }
}
