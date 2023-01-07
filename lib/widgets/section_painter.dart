import 'package:dm_helper/data/vec2.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

class ImageEditor extends CustomPainter {
  ui.Image image;
  Vec2 point;
  late DVec2 tileSize;
  Vec2 maxTiles;
  Vec2 dispSize;

  ImageEditor({
    required this.image,
    required this.point,
    required this.maxTiles,
    required this.dispSize,
  }) {
    tileSize = new DVec2(image.width / (maxTiles.x), image.height / (maxTiles.y));
  }

  @override
  void paint(Canvas canvas, Size size) {
    //ByteData data = image.toByteData();
    /*img.Image tmp = img.copyCrop(image,
        x: (point.x * tileSize.x).floor(),
        y: (point.y * tileSize.y).floor(),
        width: (dispSize.x * tileSize.x).floor(),
        height: (dispSize.y * tileSize.y).floor()
    );
    convertImageToFlutterUi(tmp).then((value) {
      canvas.drawImage(value, new Offset(0.0, 0.0), new Paint());
    });*/
    canvas.drawImage(image, new Offset(-(point.x * tileSize.x), -(point.y * tileSize.y)), new Paint());
    print("Offset: ${-(point.x * tileSize.x)},${-(point.y * tileSize.y)}");
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

class UiImagePaint extends CustomPainter {
  ui.Image image;

  UiImagePaint({required this.image});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(image,new Offset(0.0, 0.0), new Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}