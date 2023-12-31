import 'package:flutter_flame/actors/platform.dart';

import 'base_enemy.dart';
import 'package:flame/components.dart';

class SlowEnemy extends BaseEnemy {
  SlowEnemy({Vector2? position, required Platform parentPlatform})
      : super(
          position: position,
          velocityX: 200,
          texturePath: "Main Characters/Pink Man/Run (32x32).png",
          parentPlatform: parentPlatform,
        );

  @override
  void update(double dt) {
    if (dt > 0.05) return;
    super.update(dt); 

    position.y = parentPlatform.position.y - 128;

    
    flipEnemyOnWallCollision();
    position.x += velocityX * dt;
  }
}
