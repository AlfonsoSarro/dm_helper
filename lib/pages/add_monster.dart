import 'package:dm_helper/data/themes.dart';
import 'package:dm_helper/data/vec2.dart';
import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/custom_text_field.dart';
import 'package:dm_helper/widgets/lists/list_monster.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../data/monster-data.dart';
import '../widgets/filled_button.dart';

class AddMonsterPage extends StatefulWidget {
  Vec2 coords;
  Function addMonster;

  AddMonsterPage({super.key, required this.coords, required this.addMonster});

  @override
  State<AddMonsterPage> createState() => _AddMonsterPage();
}

class _AddMonsterPage extends State<AddMonsterPage> {
  List<MonsterData> listMonster = [];
  TextEditingController searchController = TextEditingController();
  String textToSearch = "";
  bool leaving = false;
  bool requestedSearch = false;

  Future<void> fetchMonsters() async {
    final response =
        await http.get(Uri.parse("https://www.dnd5eapi.co/api/monsters"));

    Map<String, dynamic> responseJson = json.decode(response.body.toString());
    int numMonsters = responseJson["count"];
    requestedSearch = false;
    for (int i = 0; i < numMonsters && !leaving && !requestedSearch; i++) {
      await createMonster(responseJson["results"][i]["index"]);
    }
  }

  Future<void> createMonster(String index) async {
    final detailedResponse = await http
        .get(Uri.parse("https://www.dnd5eapi.co/api/monsters/$index"));
    Map<String, dynamic> detailedResponseJson =
        json.decode(detailedResponse.body.toString());
    String imageUrl;
    if (detailedResponseJson["image"] == null) {
      imageUrl =
          "https://www.shutterstock.com/image-vector/no-image-photography-vector-icon-260nw-1736619599.jpg";
    } else {
      imageUrl = "https://www.dnd5eapi.co" + detailedResponseJson["image"];
    }

    MonsterData newMonster = MonsterData(
        index,
        widget.coords,
        imageUrl,
        detailedResponseJson["name"],
        detailedResponseJson["hit_points"].toInt(),
        detailedResponseJson["armor_class"][0]["value"],
        detailedResponseJson["challenge_rating"].toInt());
    if (!leaving && !requestedSearch) {
      if (textToSearch == "" ||
              detailedResponseJson["name"].toLowerCase().contains(textToSearch.toLowerCase())) {
        setState(() {
          listMonster.add(newMonster);
        });
      }
    }
  }

  void search() {
    requestedSearch = true;
    textToSearch = searchController.text;
    setState(() {
      listMonster.clear();
    });
    fetchMonsters();
  }

  Widget printMonster(MonsterData monsterData) {
    return GestureDetector(
        onTap: () {
          widget.addMonster(monsterData);
          Navigator.of(context).pop();
        },
        child: MyThemes.primaryText(monsterData.index));
  }

  @override
  void initState() {
    fetchMonsters();
    super.initState();
  }

  @override
  void dispose() {
    leaving = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(
            title: "Add Monster",
            goBack: true,
            child: Column(children: <Widget>[
              Stack(alignment: Alignment.centerRight, children: <Widget>[
                CustomTextField(
                  hint: "Search",
                  controller: searchController,
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                      top: 12,
                      right: 40,
                      bottom: 12,
                    ),
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                          gradient: MyThemes.goldGradient,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      padding: const EdgeInsets.fromLTRB(5, 0.8, 5, 0.8),
                      child: IconButton(
                        onPressed: search,
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                          backgroundColor:
                              MaterialStateProperty.all(MyThemes.primary),
                        ),
                        icon: Icon(Icons.search),
                      ),
                    ))
              ]),
              Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      itemCount: listMonster.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: ListMonster(
                            monsterData: listMonster[index],
                            width: MediaQuery.of(context).size.width * 8 / 9,
                            height: 100,
                            addMonster: widget.addMonster,
                          ),
                        );
                      })),
            ])),
        LoadingScreen(
          visible: false,
        ),
      ],
    );
  }
}
