import 'package:dm_helper/data/vec2.dart';

class MonsterData {
  static const noImgFound = "https://www.shutterstock.com/image-vector/no-image-photography-vector-icon-260nw-1736619599.jpg";
  String index;
  Vec2 pos;
  String imgUrl;
  String name;
  int hp;
  int ac;
  int cr;

  MonsterData(this.index, this.pos, this.imgUrl, this.name, this.hp, this.ac, this.cr);

  factory MonsterData.fromJson(Map<String, dynamic> parsedJson){
    String imgLink = noImgFound;
    if (parsedJson["imgUrl"] != null) {
      imgLink = parsedJson["imgUrl"];
    }
    return MonsterData(parsedJson["index"], Vec2.fromJson(parsedJson["pos"]), imgLink, parsedJson["name"], parsedJson["hp"], parsedJson["ac"], parsedJson["cr"]);
  }

  static List<MonsterData> fromJsonList(List<dynamic> rawData){
    List<MonsterData> out = [];

    rawData.forEach((element) {
      out.add(MonsterData.fromJson(element));
    });

    return out;
  }

  Map toJson() => {
    "index": index,
    "pos": pos.toJson(),
    "imgUrl": imgUrl,
    "name": name,
    "hp": hp,
    "ac": ac,
    "cr": cr
  };
}