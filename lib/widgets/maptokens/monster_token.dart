import 'package:dm_helper/data/vec2.dart';
import 'package:dm_helper/pages/map_page.dart';
import 'package:dm_helper/widgets/maptokens/dragable_token.dart';
import 'package:flutter/material.dart';

class MonsterToken extends StatelessWidget {
  Vec2 coords;

  MonsterToken({Key? key, required this.coords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: DraggableToken(
        coords: coords,
        child: SizedBox(
            width: MediaQuery.of(context).size.width/(MapPage.dispTiles.x+1),
            height: MediaQuery.of(context).size.width/(MapPage.dispTiles.x+1),
            child: const DecoratedBox(
                decoration: const BoxDecoration(
                    color: Colors.red
                )
            )
        ),
      ),
    );
  }

}
