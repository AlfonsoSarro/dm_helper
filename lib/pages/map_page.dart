import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dm_helper/control/rect_clip.dart';
import 'package:dm_helper/data/vec2.dart';
import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:dm_helper/widgets/section_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

import '../widgets/map_element.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  String mapPath = "assets/maps/RoadMap.png";
  Vec2 maxTiles = new Vec2(30, 30);
  Vec2 dispTiles = new Vec2(5, 9);
  Vec2 point = new Vec2(0,0);
  ui.Image? mapBackground;
  bool doneLoading = false;
  int sensitivity = 10;
  List<int> counter = [0,0,0,0];

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

  Future<ui.Image> loadImage(Uint8List img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  Future<ui.Image> setImage() async {
    ByteData data = await rootBundle.load(mapPath);
    //ui.Image out = await decodeImageFromList(data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    ui.Image out = await loadImage(new Uint8List.view(data.buffer));
    return out;
  }

  void initialSetup() {
    setImage().then((value) {
      mapBackground = value;
      setState(() {
        doneLoading = true;
      });
    });
    for (int i = 0; i < maxTiles.x; i++) {
      mapData.add([]);
      for (int j = 0; j < maxTiles.y; j++) {
        mapData[i].add(new MapElement(title: "(${i},${j})",));
      }
    }
  }

  Widget showImage() {
    if (this.doneLoading) {
      return CustomPaint(
        painter: ImageEditor(image: mapBackground!, point: point, maxTiles: maxTiles)
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

  @override
  Widget build(BuildContext context) {
    initialSetup();
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
