import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../data/vec2.dart';

class MonsterInfoPage extends StatefulWidget {
  Vec2 coords;
  String monsterIndex;

  MonsterInfoPage({super.key, required this.coords, required this.monsterIndex});

  @override
  State<MonsterInfoPage> createState() => _MonsterInfoPage();
}

class _MonsterInfoPage extends State<MonsterInfoPage> {
  late Map<String, dynamic> responseJson;
  String monsterName = "Loading...";
  String ac = "";
  String hp = "";
  String speed = "";
  String str = "";
  String dex = "";
  String con = "";
  String int = "";
  String wis = "";
  String cha = "";
  String desc = "";


  Future<void> fetchMonsterInfo() async {
    final response = await http.get(Uri.parse("https://www.dnd5eapi.co/api/monsters/${widget.monsterIndex}"));

    responseJson = json.decode(response.body.toString());

    setState(() {
      monsterName = responseJson["name"];
      ac = responseJson["armor_class"][0]["value"];
      hp = responseJson["hit_points"];
      speed = responseJson["speed"][0]["walk"];
      str = responseJson["strength"];
      dex = responseJson["dexterity"];
      con = responseJson["constitution"];
      int = responseJson["intelligence"];
      wis = responseJson["wisdom"];
      cha = responseJson["charisma"];
      desc = "uhhhh....";
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
        Background(title: monsterName,),
        LoadingScreen(visible: false,),
      ],
    );
  }
}