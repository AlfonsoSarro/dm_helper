import 'package:dm_helper/data/vec2.dart';

class MonsterData {
  String index;
  Vec2 pos;

  MonsterData(this.index, this.pos);

  factory MonsterData.fromJson(Map<String, dynamic> parsedJson){
    return MonsterData(parsedJson["index"], parsedJson["pos"]);
  }

  static List<MonsterData> fromJsonList(String rawData){

    print(rawData);

    return [];
  }

  Map toJson() => {
    "index": index,
    "pos": pos.toJson()
  };
}