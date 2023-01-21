import 'package:dm_helper/data/monster-data.dart';
import 'package:dm_helper/data/vec2.dart';
import 'package:uuid/uuid.dart';

class MapData {
  late String id;
  String title;
  String description;
  String mapPath;
  late Vec2 size;
  late List<MonsterData> data;

  MapData(this.title, this.description, this.mapPath) {
    data = [];
    size = new Vec2(30, 30); //TODO change the width depending on the map
    id = Uuid().v4();
    data.add(MonsterData("brown-bear", new Vec2(9, 9)));
    data.add(MonsterData("aboleth", new Vec2(10, 10)));
    data.add(MonsterData("deva", new Vec2(11, 11)));
  }

  MapData.forAllInfo({required this.id, required this.title, required this.description, required this.mapPath, required this.size, required this.data});

  void delMonster(Vec2 pos) {
    for (var i = 0; i < data.length; i++ ) {
      if (pos.isEqualTo(data[i].pos)) {
        data.removeAt(i);
        break;
      }
    }
  }

  void addMonster(Vec2 pos, String index) {
    data.add(MonsterData(index, pos));
  }
  
  factory MapData.fromJson(Map<String, dynamic> parsedJson) {
    return MapData.forAllInfo(
        id: parsedJson["id"].toString(),
        title: parsedJson["title"].toString(),
        description: parsedJson["description"].toString(),
        mapPath: parsedJson["mapPath"].toString(),
        size: Vec2.fromJson(parsedJson["size"]),
        data: MonsterData.fromJsonList(parsedJson["data"].toString())
    );
  }

  Map toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "mapPath": mapPath,
    "size": size.toJson(),
    "data": data.map((e) => e.toJson()).toList()
  };

}