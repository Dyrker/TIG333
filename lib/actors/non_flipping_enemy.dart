import 'package:flutter_flame/actors/platform.dart';
import 'base_enemy.dart';
import 'package:flame/components.dart';

class NonFlippingEnemy extends BaseEnemy {
  NonFlippingEnemy({Vector2? position, required Platform parentPlatform})
      : super(
          position: position,
          velocityX: 400,
          texturePath: "Main Characters/Virtual Green Guy/Run (32x32).png",
          parentPlatform: parentPlatform,
        );

  @override
  void update(double dt) {
    super.update(dt); // Call the base class's update method
    
    position.y = parentPlatform.position.y - 128;

    // Custom update logic specific to the FastEnemy class
    position.x += velocityX * dt;

     if(position.x > 1080){
      position.x = -100;
     }
     
  }
}
