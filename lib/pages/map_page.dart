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
import 'dart:ui' as ui;

import '../widgets/map_element.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  String mapPath = "assets/images/RoadMap.png";
  Vec2 maxTiles = new Vec2(30, 30);
  Vec2 dispTiles = new Vec2(5, 9);
  Vec2 point = new Vec2(0,0);


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
  /*
  Future<ui.Image> loadImage() async {
    File file = new File(mapPath);
    var imgData = await file.readAsBytes();
    final ImmutableBuffer buffer = await ImmutableBuffer.fromUint8List(imgData);
    final desc = await ImageDescriptor.encoded(buffer);
    desc.
    //Check how to draw on an image using custom painter
  }*/

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < maxTiles.x; i++) {
      mapData.add([]);
      for (int j = 0; j < maxTiles.y; j++) {
        mapData[i].add(new MapElement(title: "(${i},${j})",));
      }
    }
    return Stack(
      children: <Widget>[
        Background(
          title: "Map",
          child: Stack(
            children: [
              /*ClipPath(
                clipper: RectClip(point, Vec2(dispTiles.x + point.x-1, dispTiles.y + point.y-1), maxTiles),
                child: Container(
                  child: Image.asset(mapPath,
                  fit: BoxFit.none,),
                ),
              ),*/
              CustomPaint(
                foregroundPainter: SectionPainter(
                  image: ,
                  point: point,
                  dispSize: dispTiles,
                  maxTiles: maxTiles,
                ),
              ),
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
                      if (point.x < maxTiles.x - dispTiles.x) {
                        point.x++;
                      }
                    });
                  }
                  if (details.delta.dx > 0) {
                    setState(() {
                      if (point.x > 0) {
                        point.x--;
                      }
                    });
                  }
                  if (details.delta.dy < 0) {
                    setState(() {
                      if (point.y < maxTiles.y - dispTiles.y) {
                        point.y++;
                      }
                    });
                  }
                  if (details.delta.dy > 0) {
                    setState(() {
                      if (point.y > 0) {
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