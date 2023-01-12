import 'package:dm_helper/data/vec2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


//TODO make stateful
//TODO make draggable
//TODO give finger the widget on drag
//TODO move screen when close to edge with the drag
class MapElement extends StatelessWidget {
  String? title = "Hold";
  Vec2 coords;
  var onClick;

  MapElement({Key? key, this.title, required this.coords, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox (
        width: MediaQuery.of(context).size.width/5,
        height: MediaQuery.of(context).size.width/5,
        child: GestureDetector(
          onTap: () {
            onClick(coords.x, coords.y);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Color.fromARGB(100, 255, 255, 255),
            ),
            alignment: Alignment.center,
            child: Text(title!),
          ),
        )
      ),
    );
  }
}