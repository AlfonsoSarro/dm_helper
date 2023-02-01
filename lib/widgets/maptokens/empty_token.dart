import 'package:flutter/material.dart';

import '../../data/drag_data.dart';
import '../../data/vec2.dart';
import '../../pages/map_page.dart';

class EmptyToken extends StatelessWidget {
  Vec2 coords;

  EmptyToken(this.coords);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width/(MapPage.dispTiles.x+1),
      height: MediaQuery.of(context).size.width/(MapPage.dispTiles.x+1),
    );
  }

}
