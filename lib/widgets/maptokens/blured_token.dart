import 'package:dm_helper/pages/map_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlurredToken extends StatelessWidget {
  Widget child;


  BlurredToken({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: child,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: const Color.fromARGB(100, 255, 255, 255),
          ),
          width: MediaQuery.of(context).size.width/MapPage.dispTiles.x,
          height: MediaQuery.of(context).size.width/MapPage.dispTiles.x,
        )
      ],
    );
  }

}