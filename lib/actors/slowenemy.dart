import 'baseenemy.dart';
import 'package:flame/components.dart';

class SlowEnemy extends BaseEnemy {

  SlowEnemy({Vector2? position})
      : super(
          position: position,
          velocityX: 100,
          texturePath: "Main Characters/Pink Man/Run (32x32).png",
        );

  @override
  void update(double dt) {
    super.update(dt); // Call the base class's update method

    // Custom update logic specific to the Enemy class
    flipEnemyOnWallCollision();
    position.x += velocityX * dt;
  }
}
