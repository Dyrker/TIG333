import 'package:flame/game.dart';
import "package:flutter_flame/actors/platform.dart";

class PlatformInstances {
  static late final platform1;
  static late final platform2;
  static late final platform3;
  static late final platform4;
  static late final platform5;

  PlatformInstances.initialize() {
    List yPos = [480, 960, 1440, 1920, 2400];
    double platformHeight = 64;

    platform1 = Platform(position: Vector2(0, yPos[0] - platformHeight));

    platform2 = Platform(position: Vector2(0, yPos[1] - platformHeight));

    platform3 = Platform(position: Vector2(0, yPos[2] - platformHeight));

    platform4 = Platform(position: Vector2(0, yPos[3] - platformHeight));

    platform5 = Platform(position: Vector2(0, yPos[4] - platformHeight));
  }

  static List getPlatforms() {
    return [platform1, platform2, platform3, platform4, platform5];
  }
}
