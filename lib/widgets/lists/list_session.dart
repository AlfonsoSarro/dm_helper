import 'package:dm_helper/control/cloud_storage.dart';
import 'package:dm_helper/data/map-data.dart';
import 'package:dm_helper/data/themes.dart';
import 'package:dm_helper/pages/map_page.dart';
import 'package:dm_helper/widgets/lists/list_back.dart';
import 'package:dm_helper/widgets/token.dart';
import 'package:flutter/material.dart';

class SessionList extends StatelessWidget {
  MapData mapData;
  double height;
  double width;
  Function refFunc;
  BuildContext? context;
  SessionList ({Key? key, required this.mapData, required this.width, required this.height, required this.refFunc}): super (key: key);

  void onTap(BuildContext context) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => MapPage(mapData: mapData, refreshFunc: refFunc,),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        )
    );
  }

  void onDelete() async {
    await CloudStorage.deleteMap(mapData);
    refFunc();
  }

  void imageTap(String string) {
    onTap(context!);
  }



  @override
  Widget build(BuildContext context) {
    if(this.context == null) {
      this.context = context;
    }
    return Container(
      child: GestureDetector(
        onTap: () {
          onTap(context);
        },
        child: ListBack(
          width: width,
          height: height,
          child: Container(
            height: height,
            width: width*4/5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Token(rim: MyThemes.primary, imgPath: mapData.mapPath, size: height*6/8, rimWidth: 2, func: imageTap,),
                    Container(
                      width: MediaQuery.of(context).size.width/3,
                      margin: EdgeInsets.only(left: 10),
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyThemes.secondaryText(mapData.title),
                          MyThemes.secondaryText(mapData.description),
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: onDelete,
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.delete,
                      color: MyThemes.primary,
                      size: height/2,
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}