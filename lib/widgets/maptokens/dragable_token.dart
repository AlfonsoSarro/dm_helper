import 'package:dm_helper/data/monster-data.dart';
import 'package:dm_helper/data/vec2.dart';
import 'package:dm_helper/widgets/maptokens/blured_token.dart';
import 'package:dm_helper/widgets/maptokens/monster_token.dart';
import 'package:flutter/cupertino.dart';

import '../../data/drag_data.dart';

class DraggableToken extends StatelessWidget {
  Widget child;
  Vec2 coords;
  MonsterData data;

  DraggableToken({Key? key, required this.child, required this.coords, required this.data}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Draggable<DragData>(
      data: DragData(data, MonsterToken(data: data,)),
      feedback: child,
      childWhenDragging: BlurredToken(
        child: child,
      ),
      child: child,
    );
  }

}
