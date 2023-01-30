import 'package:dm_helper/data/themes.dart';
import 'package:dm_helper/data/vec2.dart';
import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../data/monster-data.dart';

class AddMonsterPage extends StatefulWidget {
  Vec2 coords;
  AddMonsterPage({super.key, required this.coords});

  @override
  State<AddMonsterPage> createState() => _AddMonsterPage();
}

class _AddMonsterPage extends State<AddMonsterPage> {

  List<MonsterData> listMonster = [];

  Future<void> fetchMonsters() async {
    final response = await http.get(Uri.parse("https://www.dnd5eapi.co/api/monsters"));
    print(response.body.toString());
    Map<String, dynamic> responseJson = json.decode(response.body.toString());
    int numMonsters = responseJson["count"];
    print(numMonsters);
    //print(responseJson.toString());
    for(int i = 0; i < numMonsters; i++) {
      await createMonster(responseJson["results"][i]["index"]);
    }
  }

  Future<void> createMonster(String index) async {
    final detailedResponse = await http.get(Uri.parse("https://www.dnd5eapi.co/api/monsters/$index"));
    Map<String, dynamic> detailedResponseJson = json.decode(detailedResponse.body.toString());
    String imageUrl;
    if(detailedResponseJson["image"] == null) {
      imageUrl = "noImgFound";
    }
    else {
      imageUrl = detailedResponseJson["image"];
    }
    MonsterData newMonster = MonsterData(index, widget.coords, imageUrl, detailedResponseJson["name"]);
    setState(() {
      listMonster.add(newMonster);
    });
  }

  Widget printMonster(MonsterData monsterData) {
    return Container(
      child: MyThemes.primaryText(monsterData.index)
    );
  }

  @override
  void initState() {
    fetchMonsters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(title: "Add Monster",
          child: Container(
            alignment: Alignment.center,
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                itemCount: listMonster.length,
                itemBuilder: (BuildContext context, int index) {
                  return printMonster(listMonster[index]);
                }
            ),
          ),
        ),
        LoadingScreen(visible: false,),

      ],
    );
  }
}