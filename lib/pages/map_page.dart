import 'dart:async';
import 'dart:typed_data';


import 'package:dm_helper/control/cloud_storage.dart';
import 'package:dm_helper/data/map-data.dart';
import 'package:dm_helper/data/monster-data.dart';
import 'package:dm_helper/data/vec2.dart';
import 'package:dm_helper/pages/monster_info.dart';
import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:dm_helper/widgets/maptokens/empty_token.dart';
import 'package:dm_helper/widgets/maptokens/monster_token.dart';
import 'package:dm_helper/widgets/section_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

import '../widgets/map_element.dart';
import '../control/image_functions.dart';

import 'add_monster.dart';

class MapPage extends StatefulWidget {
  static Vec2 dispTiles = new Vec2(5, 9);
  MapData mapData;
  Function refreshFunc;
  MapPage({super.key, required this.mapData, required this.refreshFunc});

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  String mapPath = "";
  Vec2 maxTiles = new Vec2(30, 30);
  Vec2 point = new Vec2(0,0);
  late DVec2 tileSize;
  img.Image? mapBackground;
  Uint8List? dispImage;
  ui.Image? displayImage;
  bool doneLoading = false;
  int sensitivity = 10;
  List<int> counter = [0,0,0,0];
  bool setupDone = false;
  bool leaving = false;

  List<List<Widget>> mapData = [];

  Widget getShowMap() {
    List<Widget> out = [];
    //print("New Map: (${point.x},${point.y})");
    for (int y = point.y; y < MapPage.dispTiles.y + point.y; y++) {
      for (int x = point.x; x < MapPage.dispTiles.x + point.x; x++) {
        out.add(mapData[x][y]);
        //out.add(Text("${x},${y}"));
      }
    }
    //print("New Map: ${printData(out)}");
    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width/5
      ),
      physics: const NeverScrollableScrollPhysics(),
      children: out,
    );
  }
  
  String printData(List<MapElement> tmp) {
    String out = "[";
    
    tmp.forEach((element) { 
      out+= "(${element.coords.x},${element.coords.y}) ,";
    });
    out+= "]";
    return out;
  }

  void initialSetup(BuildContext context) {
    if (this.setupDone) {
      createNewCrop(mapBackground!, context);
    }
  }

  Widget showImage() {
    if (this.doneLoading) {
      return CustomPaint(
        painter: UiImagePaint(image: displayImage!),
      );
    }
    else {
      return Text("Loading");
    }
  }

  bool checkSens(int i) {
    counter[i]++;
    if (counter[i] > sensitivity) {
      counter[i] = 0;
      return true;
    }
    return false;
  }

  void createNewCrop(img.Image image, BuildContext context) async{
    img.Image tmp = img.copyCrop(image,
        x: (point.x * tileSize.x).floor(),
        y: (point.y * tileSize.y).floor(),
        width: (MapPage.dispTiles.x * tileSize.x).floor(),
        height: (MapPage.dispTiles.y * tileSize.y).floor()
    );

    tmp = img.copyResize(tmp, width: MediaQuery.of(context).size.width.floor());

    if(mounted) {
      ImageFunctions.convertImageToFlutterUi(tmp).then((value) {
        setState(() {
          displayImage = value;
          doneLoading = true;
        });
      });
    }
  }

  //Function that gets executed when a squere is clicked
  //  token: the squere clicked
  //  coord: the Vec2 of the position of the click
  void onClick(Vec2 coord, Widget token) {
    if (token is EmptyToken) {
      Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => AddMonsterPage(coords: coord,addMonster: addMonster,),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          )
      );
    }
    else {
      MonsterToken monsterToken = token as MonsterToken;
      Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => MonsterInfoPage(coords: coord, monster: monsterToken.data, delMonster: delMonster,),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          )
      );
    }
  }

  void addMonster(MonsterData monsterData) async {
    setTile(monsterData.pos, MonsterToken(data: monsterData,));
    widget.mapData.data.add(monsterData);
    await CloudStorage.uploadMap(widget.mapData);
  }

  void delMonster(MonsterData monsterData) async {
    setTile(monsterData.pos, EmptyToken(monsterData.pos));
    widget.mapData.data.remove(monsterData);
    await CloudStorage.uploadMap(widget.mapData);
  }

  //Function to set a particular tile to the widget provided
  void setTile(Vec2 coords, Widget newTile){
    setState(() {
      mapData[coords.x][coords.y] = MapElement(coords: coords, token: newTile, onClick: onClick, setter: setTile);
    });
  }

  Future<void> leave() async{
    await CloudStorage.uploadMap(widget.mapData);
    widget.refreshFunc();
  }

  @override
  void dispose() {
    leaving = true;
    displayImage = null;
    leave();
    super.dispose();
  }

  @override
  void initState() {
    mapPath = widget.mapData.mapPath;
    maxTiles = widget.mapData.size;
    ImageFunctions.decodeAsset(mapPath).then((value) {
      mapBackground = value;
      if (value != null) {
        tileSize = new DVec2(value.width / (maxTiles.x), value.height / (maxTiles.y));
        createNewCrop(value, context);
        setupDone = true;
      }
    });
    for (int i = 0; i < maxTiles.x; i++) {
      mapData.add([]);
      for (int j = 0; j < maxTiles.y; j++) {
        mapData[i].add(new MapElement(
            coords: new Vec2(i, j),
            token: new EmptyToken(new Vec2(i, j)),
            onClick: onClick,
            setter: setTile)
        );
        //mapData[i].add(new EmptyToken(setter: () {}, coords: new Vec2(i, j)));
      }
    }
    print(widget.mapData.data);
    widget.mapData.data.forEach((element) {
      mapData[element.pos.x][element.pos.y] = MapElement(coords: element.pos, token: MonsterToken(data: element), onClick: onClick, setter: setTile);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initialSetup(context);
    return Stack(
      children: <Widget>[
        Background(
          title: "Map",
          goBack: true,
          child: Stack(
            children: [
              showImage(),
              getShowMap(),
              GestureDetector(
                onPanUpdate: (details) {
                  if (details.delta.dx < 0) {
                    setState(() {
                      if (point.x < maxTiles.x - MapPage.dispTiles.x && checkSens(0)) {
                        point.x++;
                      }
                    });
                  }
                  if (details.delta.dx > 0) {
                    setState(() {
                      if (point.x > 0 && checkSens(1)) {
                        point.x--;
                      }
                    });
                  }
                  if (details.delta.dy < 0) {
                    setState(() {
                      if (point.y < maxTiles.y - MapPage.dispTiles.y && checkSens(2)) {
                        point.y++;
                      }
                    });
                  }
                  if (details.delta.dy > 0) {
                    setState(() {
                      if (point.y > 0 && checkSens(3)) {
                        point.y--;
                      }
                    });
                  }
                },
              )
            ],
          ),
        ),
        LoadingScreen(visible: false,),
      ],
    );
  }
}
