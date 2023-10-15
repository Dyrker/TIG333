import 'package:flame/game.dart';
import "package:flutter_flame/actors/platform.dart";
import 'package:flutter_flame/actors/enemy.dart';

class PlatformInstances {
  static late final platform1;
  static late final platform2;
  static late final platform3;
  static late final platform4;
  static late final platform5;

  PlatformInstances.initialize() {
    List yPos = [480, 960, 1440, 1920, 2400];
    double platformHeight = 64;

    platform1 = Platform(position: Vector2(0, yPos[0] - platformHeight), enemy: Enemy(position: Vector2(0, yPos[0] - platformHeight - 64)));
    platform2 = Platform(position: Vector2(0, yPos[1] - platformHeight), enemy: Enemy(position: Vector2(256, yPos[1] - platformHeight - 64)));
    platform3 = Platform(position: Vector2(0, yPos[2] - platformHeight), enemy: Enemy(position: Vector2(612, yPos[2] - platformHeight - 64)));
    platform4 = Platform(position: Vector2(0, yPos[3] - platformHeight), enemy: Enemy(position: Vector2(0, yPos[3] - platformHeight - 64)));
    platform5 = Platform(position: Vector2(0, yPos[4] - platformHeight), enemy: Enemy(position: Vector2(256, yPos[4] - platformHeight - 64)));
  }

  List getPlatforms() {
    return [platform1, platform2, platform3, platform4, platform5];
  }
}
