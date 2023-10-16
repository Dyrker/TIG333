import 'baseenemy.dart';
import 'package:flame/components.dart';

class Enemy extends BaseEnemy {

  Enemy({Vector2? position})
      : super(
          position: position,
          velocityX: 300,
          texturePath: "Main Characters/Mask Dude/Run (32x32).png",
        );

  @override
  void update(double dt) {
    super.update(dt); // Call the base class's update method

    // Custom update logic specific to the Enemy class
    flipEnemyOnWallCollision();
    position.x += velocityX * dt;
  }
}
