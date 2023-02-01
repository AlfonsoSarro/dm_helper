import 'dart:core';

import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../data/themes.dart';
import '../data/vec2.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/filled_button.dart';

class MonsterInfoPage extends StatefulWidget {
  Vec2 coords;
  String monsterIndex;

  MonsterInfoPage(
      {super.key, required this.coords, required this.monsterIndex});

  @override
  State<MonsterInfoPage> createState() => _MonsterInfoPage();
}

class _MonsterInfoPage extends State<MonsterInfoPage> {
  late Map<String, dynamic> responseJson;
  String monsterName = "Loading...";
  String ac = "";
  String hp = "";
  String speed = "";
  String finalStr = "";
  String finalDex = "";
  String finalCon = "";
  String finalIntelligence = "";
  String finalWis = "";
  String finalCha = "";
  String desc = "\n";
  String img =
      "https://www.shutterstock.com/image-vector/no-image-photography-vector-icon-260nw-1736619599.jpg";

  Future<void> fetchMonsterInfo() async {
    final response = await http.get(Uri.parse(
        "https://www.dnd5eapi.co/api/monsters/${widget.monsterIndex}"));

    responseJson = json.decode(response.body.toString());

    setState(() {
      monsterName = responseJson["name"];
      img = "https://www.dnd5eapi.co" + responseJson["image"];
      ac = responseJson["armor_class"][0]["value"].toString();
      hp = responseJson["hit_points"].toString();
      speed = responseJson["speed"]["walk"].toString();
      int str = responseJson["strength"];
      int dex = responseJson["dexterity"];
      int con = responseJson["constitution"];
      int intelligence = responseJson["intelligence"];
      int wis = responseJson["wisdom"];
      int cha = responseJson["charisma"];
      if(responseJson["special_abilities"].length == 0) {
        desc = "This monster does not have any special abilities.";
      }
      else {
        for(int i = 0; i < responseJson["special_abilities"].length; i++) {
          desc = desc + "\t\t" + responseJson["special_abilities"][i]["name"] + ": ";
          desc = desc + responseJson["special_abilities"][i]["desc"] + "\n\n";
        }
      }
      finalStr = "$str +${(str - 10) ~/ 2}";
      finalDex = "$dex +${(dex - 10) ~/ 2}";
      finalCon = "$con +${(con - 10) ~/ 2}";
      finalIntelligence = "$intelligence +${(intelligence - 10) ~/ 2}";
      finalWis = "$wis +${(wis - 10) ~/ 2}";
      finalCha = "$cha +${(cha - 10) ~/ 2}";
    });
  }

  @override
  void initState() {
    fetchMonsterInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(
          title: monsterName,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.network(img),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Column(children: [
                              MyThemes.secondaryText("AC"),
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: MyThemes.primary,
                                        shape: BoxShape.circle),
                                    child: ClipOval(
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(100 / 2),
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              color: CupertinoColors.white,
                                              shape: BoxShape.circle),
                                          child: Stack(children: <Widget>[
                                            Center(
                                                child: Image.asset(
                                                    'assets/images/shield.png')),
                                            Center(
                                                child: MyThemes.primaryTextSizeable(
                                                    ac, 40)),
                                          ]),
                                        ),
                                      ),
                                    )),
                              )
                            ])),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Column(children: [
                              MyThemes.secondaryText("HP"),
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: MyThemes.primary,
                                        shape: BoxShape.circle),
                                    child: ClipOval(
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(100 / 2),
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              color: CupertinoColors.white,
                                              shape: BoxShape.circle),
                                          child: Stack(children: <Widget>[
                                            Center(
                                                child: Image.asset(
                                                    'assets/images/heart.png')),
                                            Center(
                                                child: MyThemes.primaryTextSizeable(
                                                    hp, 40)),
                                          ]),
                                        ),
                                      ),
                                    )),
                              )
                            ])),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Column(children: [
                              MyThemes.secondaryText("Speed"),
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: MyThemes.primary,
                                        shape: BoxShape.circle),
                                    child: ClipOval(
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(100 / 2),
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              color: CupertinoColors.white,
                                              shape: BoxShape.circle),
                                          child: Stack(children: <Widget>[
                                            Center(
                                                child: Image.asset(
                                                    'assets/images/boot.jpeg')),
                                            Center(
                                                child: MyThemes.primaryTextSizeable(
                                                    ac, 40)),
                                          ]),
                                        ),
                                      ),
                                    )),
                              )
                            ]))
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Column(children: [
                              MyThemes.secondaryText("STR"),
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: MyThemes.primary,
                                        shape: BoxShape.circle),
                                    child: ClipOval(
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(100 / 2),
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              color: CupertinoColors.white,
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: MyThemes.primaryTextSizeable(
                                                finalStr, 40),
                                          ),
                                        ),
                                      ),
                                    )),
                              )
                            ])),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Column(children: [
                              MyThemes.secondaryText("DEX"),
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: MyThemes.primary,
                                        shape: BoxShape.circle),
                                    child: ClipOval(
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(100 / 2),
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              color: CupertinoColors.white,
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: MyThemes.primaryTextSizeable(
                                                finalDex, 40),
                                          ),
                                        ),
                                      ),
                                    )),
                              )
                            ])),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Column(children: [
                              MyThemes.secondaryText("CON"),
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: MyThemes.primary,
                                        shape: BoxShape.circle),
                                    child: ClipOval(
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(100 / 2),
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              color: CupertinoColors.white,
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: MyThemes.primaryTextSizeable(
                                                finalCon, 40),
                                          ),
                                        ),
                                      ),
                                    )),
                              )
                            ]))
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Column(children: [
                              MyThemes.secondaryText("INT"),
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: MyThemes.primary,
                                        shape: BoxShape.circle),
                                    child: ClipOval(
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(100 / 2),
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              color: CupertinoColors.white,
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: MyThemes.primaryTextSizeable(
                                                finalIntelligence, 40),
                                          ),
                                        ),
                                      ),
                                    )),
                              )
                            ])),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Column(children: [
                              MyThemes.secondaryText("WIS"),
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: MyThemes.primary,
                                        shape: BoxShape.circle),
                                    child: ClipOval(
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(100 / 2),
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              color: CupertinoColors.white,
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: MyThemes.primaryTextSizeable(
                                                finalWis, 40),
                                          ),
                                        ),
                                      ),
                                    )),
                              )
                            ])),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Column(children: [
                              MyThemes.secondaryText("CHA"),
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: MyThemes.primary,
                                        shape: BoxShape.circle),
                                    child: ClipOval(
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(100 / 2),
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              color: CupertinoColors.white,
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: MyThemes.primaryTextSizeable(
                                                finalCha, 40),
                                          ),
                                        ),
                                      ),
                                    )),
                              )
                            ]))
                      ]),

                      MyThemes.secondaryText("Description"),


               Container(
                 margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    width: MediaQuery.of(context).size.width * 8/9,
                    decoration: BoxDecoration(
                        gradient: MyThemes.goldGradient,
                        borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(

                            color: const Color.fromRGBO(0, 0, 0, 1),
                            borderRadius: BorderRadius.circular(50),
                              
                        ),
                      child: MyThemes.secondaryTextMultiline(desc),
                    ),
                  ),
                  FilledButton(
                    text: MyThemes.primaryText("Delete"),
                    colorBack: MyThemes.primary,
                    callback: () {Navigator.pop(context);},
                    width: (MediaQuery.of(context).size.width - (CustomTextField.horizontalPadding*2) - 10) / 2,
                  )
                ]),
          ),
        ),
        LoadingScreen(
          visible: false,
        ),

      ],
    );
  }
}
