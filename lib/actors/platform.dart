import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter_flame/test_adventure.dart';

class Platform extends SpriteComponent with HasGameRef<TestAdventure>{

  
  Platform({position}) : super(position: position, size: Vector2(1080, 128));

  @override
  FutureOr<void> onLoad() async{
    sprite = await Sprite.load('/Terrain/redplatform.png');
    
    return super.onLoad();
  }
}
