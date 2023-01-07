import 'package:dm_helper/data/vec2.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

class SectionPainter extends CustomPainter {
  final ui.Image image;
  Vec2 point;
  Vec2 dispSize;
  DVec2 tileSize = new DVec2(0, 0);
  Vec2 maxTiles;

  SectionPainter({required this.image, required this.point, required this.dispSize, required this.maxTiles});

  @override
  void paint(Canvas canvas, Size size) {
    tileSize.x = size.width / maxTiles.x;
    tileSize.y = size.height / maxTiles.y;
    canvas.drawAtlas(
      image,
      [
        RSTransform.fromComponents(
            rotation: 0.0,
            scale: 1.0,
            anchorX: 0.0,
            anchorY: 0.0,
            translateX: 0.0,
            translateY: 0.0)
      ],
      [
        Rect.fromLTWH(point.x * tileSize.x, point.y * tileSize.y, dispSize.x * tileSize.x, dispSize.y * tileSize.y)
      ],
      [],
      BlendMode.src,
      null,
      Paint()
    );
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}