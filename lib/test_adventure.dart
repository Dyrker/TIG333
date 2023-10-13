import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame/actors/player.dart';
import 'levels/level.dart';
import 'package:flame/game.dart';

class TestAdventure extends FlameGame with TapCallbacks, HasCollisionDetection {
  late CameraComponent cam;
  final double gameWidth = 1080;
  final double gameHeight = 2400;

  @override
  Color backgroundColor() => const Color(0xFF211F30);

  @override
  final world = Level(levelName: "placeholder", player: Player(character: "Ninja Frog"));

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(world: world, width: gameWidth, height: gameHeight);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);

    return super.onLoad();
  }
}
