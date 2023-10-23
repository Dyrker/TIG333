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
    if (dt > 0.05) return;
    super.update(dt); 

    position.y = parentPlatform.position.y - 128;


    position.x += velocityX * dt;

     if(position.x > 1080){
      position.x = -100;
     }
     
  }
}
