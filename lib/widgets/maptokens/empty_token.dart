import 'package:flutter/material.dart';

import '../../data/drag_data.dart';
import '../../data/vec2.dart';

class EmptyToken extends StatelessWidget {
  Vec2 coords;
  var setter;
  EmptyToken({Key? key, required this.setter, required this.coords}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width/6,
              height: MediaQuery.of(context).size.width/6,
              child: Center(
                child: Text("(${coords.x},${coords.y})"),
              ),
              /*child: const DecoratedBox(
                  decoration: const BoxDecoration(
                      color: Colors.grey
                  )
              )*/
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
      ),
    );
  }

}