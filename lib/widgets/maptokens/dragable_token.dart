import 'package:dm_helper/data/vec2.dart';
import 'package:dm_helper/widgets/maptokens/blured_token.dart';
import 'package:flutter/cupertino.dart';

import '../../data/drag_data.dart';

class DraggableToken extends StatelessWidget {
  Widget token;
  Vec2 coords;
  var clearContent;
  var setter;

  DraggableToken({Key? key, required this.token, required this.coords, required this.clearContent, required this.setter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Draggable<DragData>(
          data: new DragData(coords, token, clearContent),
          feedback: Container(
            alignment: Alignment.center,
            child: token,
          ),
          childWhenDragging: BlurredToken(child: token, color: Color.fromARGB(100, 255, 255, 255)),
          child: Container(
            alignment: Alignment.center,
            child: token,
          ),
        ),
        DragTarget<DragData>(
          builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
              ) {
            return SizedBox(
              height: MediaQuery.of(context).size.width/5,
              width: MediaQuery.of(context).size.width/5,
            );
          },
          onAccept: (DragData data) {
            data.clearContent();
            setter(data.token);
          },
        ),
      ],
    );
  }

}