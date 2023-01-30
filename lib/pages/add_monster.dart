import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class AddMonsterPage extends StatefulWidget {
  const AddMonsterPage({super.key});

  @override
  State<AddMonsterPage> createState() => _AddMonsterPage();
}

class Monster{
  String name;
  Monster({required this.name});
}

Future<List<Monster>> fetchMonsters() async {
  final response = await http.get(Uri.parse("https://www.dnd5eapi.co/api/monsters"));
  print(response.body.toString());
  Map<String, dynamic> responseJson = json.decode(response.body.toString());
  int numMonsters = responseJson["count"];
  print(numMonsters);
  //print(responseJson.toString());
  List<Monster> monsterList = createMonsterList(responseJson["results"], numMonsters);
  return monsterList;
}

List<Monster> createMonsterList(List data, int numMonsters) {
  List<Monster> list = [];
  for (int i = 0; i < numMonsters; i++) {
    String name = data[i]["name"];
    Monster newMonster = Monster(name: name);
    list.add(newMonster);
  }
  return list;
}

class _AddMonsterPage extends State<AddMonsterPage> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(title: "Add Entity",),
        LoadingScreen(visible: false,),
        FutureBuilder<List<Monster>>(
          future: fetchMonsters(),
    builder: (context, snapshot) {
      if(snapshot.hasData) {
        return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(snapshot.data![index].name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Divider()
                  ]
              );
            }
        );
      } else if (snapshot.hasError) {
        return new Text("${snapshot.error}");
      }

      // By default, show a loading spinner
      return new CircularProgressIndicator();
    }
        )
      ],
    );
  }
}