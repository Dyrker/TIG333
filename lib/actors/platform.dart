import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_flame/test_adventure.dart';

class Platform extends SpriteComponent with HasGameRef<TestAdventure>, CollisionCallbacks{
  int numberOfPlatforms = 5;
  final hitbox = RectangleHitbox()..collisionType = CollisionType.passive;
  
  Platform({position}) : super(position: position, size: Vector2(1080, 128)){debugMode = true;}

  @override
  FutureOr<void> onLoad() async{
    sprite = await Sprite.load('Terrain/redplatform.png');
    add(hitbox);
    return super.onLoad();
  }
}
