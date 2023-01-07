import 'package:flutter/cupertino.dart';

import '../data/vec2.dart';

class RectClip extends CustomClipper<Path> {
  Vec2 point;
  Vec2 trg;
  DVec2 tileSize = new DVec2(0, 0);
  Vec2 maxTiles;

  RectClip(this.point, this.trg, this.maxTiles ){
   tileSize = new DVec2(0, 0);
  }

  @override
  Path getClip(Size size) {
    tileSize.x = size.width / maxTiles.x;
    tileSize.y = size.height / maxTiles.y;

    var path = Path();
    path.moveTo(point.x * tileSize.x, point.y * tileSize.y);
    path.lineTo(point.x * tileSize.x, trg.y * tileSize.y);
    path.lineTo(trg.x * tileSize.x, trg.y * tileSize.y);
    path.lineTo(trg.x * tileSize.x, point.y * tileSize.y);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}