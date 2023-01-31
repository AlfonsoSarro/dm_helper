import 'package:dm_helper/data/monster-data.dart';
import 'package:dm_helper/data/themes.dart';
import 'package:dm_helper/data/vec2.dart';
import 'package:dm_helper/pages/map_page.dart';
import 'package:dm_helper/widgets/maptokens/dragable_token.dart';
import 'package:flutter/material.dart';

class MonsterToken extends StatelessWidget {
  MonsterData data;

  MonsterToken({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width/(MapPage.dispTiles.x+1);
    return Container(
      alignment: Alignment.center,
      child: DraggableToken(
        coords: data.pos,
        data: data,
        child: SizedBox(
            width: width,
            height: width,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: MyThemes.primary,
                  shape: BoxShape.circle
              ),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(width/2),
                  child: Image.network(data.imgUrl, fit: BoxFit.cover,),
                ),
              ),
            )
        ),
      ),
    );
  }

}
