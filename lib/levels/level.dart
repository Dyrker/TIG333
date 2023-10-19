import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/parallax.dart';
import 'package:flutter_flame/actors/base_enemy.dart';
import 'package:flutter_flame/actors/platform_instances.dart';
import 'package:flutter_flame/actors/player.dart';
import 'package:flutter_flame/test_adventure.dart';
import '../actors/platform.dart';

class Level extends World with HasGameRef<TestAdventure>, TapCallbacks {
  final String levelName;
  Player player;
  bool jumpingDisabled = false;
  late PlatformInstances platformInstances;

  Level({required this.levelName, required this.player}) {
    platformInstances = PlatformInstances.initialize();
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (player.jumpState == JumpState.idle) {
      player.jumpHandler();
    }
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    if (player.jumpState == JumpState.shortJump) {
      player.jumpHandler();
    }
  }

  void onTapUp(TapUpEvent event) {
    player.jumpingDisabled = true;
  }

  @override
  FutureOr<void> onLoad() async {
    final ParallaxComponent skyBG = await ParallaxComponent.load(
      [ParallaxImageData('sky.png'), ParallaxImageData('clouds_bg.png')],
      baseVelocity: Vector2(20, 0),
      size: Vector2(gameRef.gameWidth, gameRef.gameHeight),
    );
    final ParallaxComponent mountainsBG = await ParallaxComponent.load(
      [ParallaxImageData('glacial_mountains.png')],
      baseVelocity: Vector2(20, -5),
      size: Vector2(gameRef.gameWidth, gameRef.gameHeight),
    );
    final ParallaxComponent cloudsBG = await ParallaxComponent.load(
      [
        ParallaxImageData('clouds_mg_3.png'),
        ParallaxImageData('clouds_mg_2.png'),
        ParallaxImageData('clouds_mg_1.png'),
      ],
      baseVelocity: Vector2(5, 0),
      velocityMultiplierDelta: Vector2(4, 0),
      size: Vector2(gameRef.gameWidth, gameRef.gameHeight),
    );
    addAll([skyBG, mountainsBG, cloudsBG]);
    addPlatformsEnemiesPlayer();

    return super.onLoad();
  }

  void removeEnemy(enemy) {
    remove(enemy);
  }

  void addEnemy(enemy) {
    add(enemy);
  }

  void addPlatformsEnemiesPlayer() {
    List platforms = platformInstances.getPlatforms();
    for (var platform in platforms) {
      add(platform);
      if (platform.position.y > 2200) {
        print("test321");
        BaseEnemy enemy = BaseEnemy.createEnemy(
            forcecase: 3, yPos: platform.position.y - 128, parentPlatform: platform);
        add(enemy);
        platform.childEnemy = enemy;
      } else {
        BaseEnemy enemy =
            BaseEnemy.createEnemy(yPos: platform.position.y - 128, parentPlatform: platform);
        add(enemy);
        platform.childEnemy = enemy;
      }
    }
    player = Player(character: player.character);
    add(player);
  }

  void restartGame() {
    var platforms = platformInstances.getPlatforms();
    for (var platform in platforms) {
      remove(platform.childEnemy);
      remove(platform);
    }
    remove(player);

    Platform.resetStaticVariables();
    platformInstances = PlatformInstances.initialize(); // new instance of PlatformInstances
    addPlatformsEnemiesPlayer();

    // moved these two lines to here from base_enemy (restartGame() is called from base_enemy)
    game.navigateBackToMainMenu();
  }
}
