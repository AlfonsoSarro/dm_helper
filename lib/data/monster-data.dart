import 'package:dm_helper/data/vec2.dart';

class MonsterData {
  static const noImgFound = "https://www.shutterstock.com/image-vector/no-image-photography-vector-icon-260nw-1736619599.jpg";
  String index;
  Vec2 pos;
  String imgUrl;

  MonsterData(this.index, this.pos, this.imgUrl);

  factory MonsterData.fromJson(Map<String, dynamic> parsedJson){
    return MonsterData(parsedJson["index"], parsedJson["pos"], parsedJson["imgUrl"]);
  }

  static List<MonsterData> fromJsonList(String rawData){

    print(rawData);

    return [];
  }

  Map toJson() => {
    "index": index,
    "pos": pos.toJson(),
    "imgUrl": imgUrl
  };
}