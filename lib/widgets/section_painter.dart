import 'package:dm_helper/data/vec2.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

class ImageEditor extends CustomPainter {
  ui.Image image;
  Vec2 point;
  late DVec2 tileSize;
  Vec2 maxTiles;

  ImageEditor({
    required this.image,
    required this.point,
    required this.maxTiles
  }) {
    tileSize = new DVec2(image.width / (maxTiles.x + 2), image.height / (maxTiles.y + 3));
  }


  @override
  void paint(Canvas canvas, Size size) {
    //ByteData data = image.toByteData();
    canvas.drawImage(image, new Offset(-(point.x * tileSize.x), -(point.y * tileSize.y)), new Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}