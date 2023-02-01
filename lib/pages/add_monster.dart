import 'package:dm_helper/data/themes.dart';
import 'package:dm_helper/data/vec2.dart';
import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/lists/list_monster.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../data/monster-data.dart';

class AddMonsterPage extends StatefulWidget {
  Vec2 coords;
  Function addMonster;
  AddMonsterPage({super.key, required this.coords, required this.addMonster});

  @override
  State<AddMonsterPage> createState() => _AddMonsterPage();
}

class _AddMonsterPage extends State<AddMonsterPage> {

  List<MonsterData> listMonster = [];
  bool done = false;
  bool leaving = false;

  Future<void> fetchMonsters() async {
    final response = await http.get(Uri.parse("https://www.dnd5eapi.co/api/monsters"));

    Map<String, dynamic> responseJson = json.decode(response.body.toString());
    int numMonsters = responseJson["count"];

    for(int i = 0; i < numMonsters && !leaving; i++) {
      await createMonster(responseJson["results"][i]["index"]);
    }
    done = true;
  }

  Future<void> createMonster(String index) async {
    final detailedResponse = await http.get(Uri.parse("https://www.dnd5eapi.co/api/monsters/$index"));
    Map<String, dynamic> detailedResponseJson = json.decode(detailedResponse.body.toString());
    String imageUrl;
    if(detailedResponseJson["image"] == null) {
      imageUrl = "https://www.shutterstock.com/image-vector/no-image-photography-vector-icon-260nw-1736619599.jpg";
    }
    else {
      imageUrl = "https://www.dnd5eapi.co" + detailedResponseJson["image"];
    }

    MonsterData newMonster = MonsterData(index, widget.coords, imageUrl, detailedResponseJson["name"], detailedResponseJson["hit_points"].toInt(), detailedResponseJson["armor_class"][0]["value"], detailedResponseJson["challenge_rating"].toInt());
    setState(() {
      listMonster.add(newMonster);
    });
  }

  Widget printMonster(MonsterData monsterData) {
    return GestureDetector(
      onTap: (){
        widget.addMonster(monsterData);
        Navigator.of(context).pop();
      },
      child: MyThemes.primaryText(monsterData.index)
    );
  }

  @override
  void initState() {
    fetchMonsters();
    super.initState();
  }

  @override
  void dispose() {
    leaving = true;
    while(!done){}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(title: "Add Monster",
          goBack: true,
          child: Container(
            alignment: Alignment.center,
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                itemCount: listMonster.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: ListMonster(
                      monsterData: listMonster[index],
                      width: MediaQuery.of(context).size.width * 8/9,
                      height: 100,
                      addMonster: widget.addMonster,
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