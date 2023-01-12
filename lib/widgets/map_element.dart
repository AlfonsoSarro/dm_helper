import 'package:dm_helper/data/drag_data.dart';
import 'package:dm_helper/data/vec2.dart';
import 'package:dm_helper/widgets/maptokens/blured_token.dart';
import 'package:dm_helper/widgets/maptokens/empty_token.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


//TODO make stateful
//TODO make draggable
//TODO give finger the widget on drag
//TODO move screen when close to edge with the drag
class MapElement extends StatefulWidget {
  String? title = "Hold";
  Vec2 coords;
  var onClick;

  MapElement({super.key, this.title, required this.coords, required this.onClick});

  @override
  State<StatefulWidget> createState() => _MapElement();

}


class _MapElement extends State<MapElement> {
  //_MapElement({Key? key, this.title, required this.coords, required this.onClick}) : super(key: key);
  late Widget token;

  void clearContent() {
    setState(() {
      token = EmptyToken(setter: tokenSetter, coords: widget.coords,);
    });
  }

  void tokenSetter(Widget input) {
    setState(() {
      token = input;
    });
  }

  @override
  void initState() {
    token = EmptyToken(setter: tokenSetter, coords: widget.coords,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox (
        width: MediaQuery.of(context).size.width/5,
        height: MediaQuery.of(context).size.width/5,
        child: GestureDetector(
          onTap: () {
            Widget tmp = widget.onClick(token, widget.coords, clearContent, tokenSetter);
            setState(() {
              token = tmp;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: const Color.fromARGB(100, 255, 255, 255),
            ),
            alignment: Alignment.center,
            child: token
          ),
        )
      ),
    );
  }
}