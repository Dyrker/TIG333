import 'package:flame/components.dart';

class StaticBackground extends SpriteComponent {
  late final Vector2 _size;

  StaticBackground(this._size);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('staticBackground.jpg');
    size = _size;
  }
}
