import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapElement extends StatelessWidget {
  String? title = "Hold";

  MapElement({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox (
        width: MediaQuery.of(context).size.width/5,
        height: MediaQuery.of(context).size.width/5,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Color.fromARGB(100, 255, 255, 255),
          ),
          alignment: Alignment.center,
          child: Text(title!),
        ),
      ),
    );
  }
}