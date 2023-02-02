import 'package:dm_helper/data/monster-data.dart';
import 'package:dm_helper/widgets/lists/list_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/themes.dart';
import '../token.dart';

class ListMonster extends StatelessWidget {
  MonsterData monsterData;
  double height;
  double width;
  Function addMonster;
  BuildContext? context;
  ListMonster ({Key? key, required this.monsterData, required this.width, required this.height, required this.addMonster}): super (key: key);

  String setupStats(MonsterData monsterData) {
    return "HP: ${monsterData.hp} AC: ${monsterData.ac} CR: ${monsterData.cr}";
  }

  void setMonster(String data) {
    addMonster(monsterData);
    Navigator.pop(context!);
  }

  @override
  Widget build(BuildContext context) {
    if(this.context == null) {
      this.context = context;
    }
    return Container(
      child: GestureDetector(
        onTap: () {
            addMonster(monsterData);
            Navigator.of(context).pop();
        },
        child: ListBack(
          width: width,
          height: height,
          child: Container(
            height: height,
            width: width * 4 / 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Token(rim: MyThemes.primary,
                        imgPath: monsterData.imgUrl,
                        size: height * 6 / 8,
                        rimWidth: 2,
                      func: setMonster,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/2.1,
                      margin: EdgeInsets.only(left: 10),
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyThemes.secondaryText(monsterData.name),
                          MyThemes.secondaryText(setupStats(monsterData)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
