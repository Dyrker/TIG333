import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'levels/level.dart';
import 'package:flame/game.dart';

class TestAdventure extends FlameGame {
  late CameraComponent cam;

  @override
  Color backgroundColor() => const Color(0xFF211F30);

  @override
  final world = Level(levelName: "lvl2");

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);

    return super.onLoad();
  }
}
