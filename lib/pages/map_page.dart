import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:flutter/cupertino.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(title: "Map",),
        LoadingScreen(visible: false,),
      ],
    );
  }
}