import 'package:dm_helper/control/cloud_storage.dart';
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

  List<MapData> maps = [];

  void getUserMaps() async {
    setState(() {
      maps = [];
    });
    List<MapData> tmp = await CloudStorage.getAllMaps();
    setState(() {
      maps = tmp;
    });
  }

  @override
  void initState() {
    getUserMaps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(title: "Sessions",
          child: Container(
            alignment: Alignment.center,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              itemCount: maps.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: SessionList(
                      mapData: maps[index],
                      width: MediaQuery.of(context).size.width * 8/9,
                      height: 100,
                      refFunc: getUserMaps,
                  ),
                );
              }
            ),
          ),
        ),
        LoadingScreen(visible: false,),
      ],
    );
  }
}