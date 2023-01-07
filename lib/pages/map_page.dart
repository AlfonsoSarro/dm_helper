import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dm_helper/data/vec2.dart';
import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:dm_helper/widgets/section_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as flutt;
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

import '../widgets/map_element.dart';
import '../control/image_functions.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  String mapPath = "assets/maps/RoadMapLow.png";
  Vec2 maxTiles = new Vec2(30, 30);
  Vec2 dispTiles = new Vec2(5, 9);
  Vec2 point = new Vec2(0,0);
  late DVec2 tileSize;
  img.Image? mapBackground;
  Uint8List? dispImage;
  late ui.Image displayImage;
  bool doneLoading = false;
  int sensitivity = 10;
  List<int> counter = [0,0,0,0];
  bool setupDone = false;

  List<List<Widget>> mapData = [];

  List<Widget> getShowMap() {
    List<Widget> out = [];

    for (int y = point.y; y < dispTiles.y + point.y; y++) {
      for (int x = point.x; x < dispTiles.x + point.x; x++) {
        out.add(mapData[x][y]);
      }
    }
    return out;
  }

  void initialSetup(BuildContext context) {
    if (this.setupDone) {
      ImageFunctions.decodeAsset(mapPath).then((value) {
        mapBackground = value;
        if (value != null) {
          tileSize =
          new DVec2(value.width / (maxTiles.x), value.height / (maxTiles.y));
          createNewCrop(value, context);
          setupDone = true;
        }
      });
      for (int i = 0; i < maxTiles.x; i++) {
        mapData.add([]);
        for (int j = 0; j < maxTiles.y; j++) {
          mapData[i].add(new MapElement(title: "(${i},${j})",));
        }
      }
    }
    else {
      createNewCrop(mapBackground!, context);
    }
  }

  Widget showImage() {
    if (this.doneLoading) {
      /*return CustomPaint(
        child: Container(),
        painter: ImageEditor(image: mapBackground!, point: point, maxTiles: maxTiles, dispSize: dispTiles)
      );*/
      //return Image.memory(dispImage!);
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
        width: (dispTiles.x * tileSize.x).floor(),
        height: (dispTiles.y * tileSize.y).floor()
    );

    tmp = img.copyResize(tmp, width: MediaQuery.of(context).size.width.floor());
    
    //img.Image tmp = img.copyCrop(image, x: 0, y: 0, width: 100, height: 100);

    ImageFunctions.convertImageToFlutterUi(tmp).then((value) {
      setState(() {
        //dispImage = Uint8List.view(pngBytes!.buffer);
        displayImage = value;
        doneLoading = true;
      });
    });
    //final pngBytes = await tmp2.toByteData(format: ImageByteFormat.png);
    /*setState(() {
      //dispImage = Uint8List.view(pngBytes!.buffer);
      displayImage = tmp2;
      doneLoading = true;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    initialSetup(context);
    return Stack(
      children: <Widget>[
        Background(
          title: "Map",
          child: Stack(
            children: [
              showImage(),
              GridView(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width/5
                  ),
                children: getShowMap(),
                physics: NeverScrollableScrollPhysics(),
              ),
              GestureDetector(
                onPanUpdate: (details) {
                  if (details.delta.dx < 0) {
                    setState(() {
                      if (point.x < maxTiles.x - dispTiles.x && checkSens(0)) {
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
                      if (point.y < maxTiles.y - dispTiles.y && checkSens(2)) {
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
