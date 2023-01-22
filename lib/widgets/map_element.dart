import 'package:dm_helper/data/drag_data.dart';
import 'package:dm_helper/data/vec2.dart';
import 'package:dm_helper/widgets/maptokens/blured_token.dart';
import 'package:dm_helper/widgets/maptokens/empty_token.dart';
import 'package:dm_helper/widgets/maptokens/monster_token.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/map_page.dart';


class MapElement extends StatelessWidget {
  Vec2 coords;
  Widget token;
  Function onClick;
  Function setter;


  MapElement({Key? key, required this.coords, required this.token, required this.onClick, required this.setter}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/MapPage.dispTiles.x,
      height: MediaQuery.of(context).size.width/MapPage.dispTiles.x,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: const Color.fromARGB(80, 255, 255, 255),
      ),
      child: GestureDetector(
        onTap: () {
          onClick(coords, token);
        },
        child: Stack(
          children: [
            token,
            DragTarget<DragData>(
              builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                  ) {
                return SizedBox(
                  height: MediaQuery.of(context).size.width/MapPage.dispTiles.x,
                  width: MediaQuery.of(context).size.width/MapPage.dispTiles.x,
                );
              },
              onAccept: (DragData data) {
                //TODO Might need to check type of token
                if (token is EmptyToken) {
                  setter(data.data.pos, EmptyToken(data.data.pos));
                  data.data.pos = coords;
                  setter(coords, MonsterToken(data: data.data,));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

}