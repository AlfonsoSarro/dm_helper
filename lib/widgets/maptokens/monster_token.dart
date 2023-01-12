import 'package:dm_helper/data/vec2.dart';
import 'package:dm_helper/widgets/maptokens/dragable_token.dart';
import 'package:flutter/material.dart';

class MonsterToken extends StatelessWidget {

  Vec2 coords;
  var clearContent;
  var setter;

  MonsterToken({Key? key, required this.coords, required this.clearContent, required this.setter}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableToken(
        coords: coords,
        clearContent: clearContent,
        setter: setter,
        token: SizedBox(
            width: MediaQuery.of(context).size.width/6,
            height: MediaQuery.of(context).size.width/6,
            child: const DecoratedBox(
                decoration: const BoxDecoration(
                    color: Colors.red
                )
            )
        ),
    );
  }

}