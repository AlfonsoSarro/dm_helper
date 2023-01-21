import 'package:dm_helper/data/map-data.dart';
import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/lists/list_back.dart';
import 'package:dm_helper/widgets/lists/list_session.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(title: "Sessions",
          child: Container(
            alignment: Alignment.center,
            child: SessionList(
              mapData: MapData("Title1", "Text", "assets/maps/RoadMapLow.png"),
              width: MediaQuery.of(context).size.width * 8/9,
              height: 100,)
          ),
        ),
        LoadingScreen(visible: false,),
      ],
    );
  }
}