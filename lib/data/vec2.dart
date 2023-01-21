class Vec2 {
  int x = 0;
  int y = 0;
  Vec2(this.x, this.y);

  factory Vec2.fromJson(Map<String, dynamic> parsedJson) {
    return Vec2(parsedJson["x"], parsedJson["y"]);
  }

  bool isEqualTo(Vec2 trg) {
    return (x == trg.x && y == trg.y);
  }

  Map toJson() => {
    "x": x,
    "y": y
  };
}

class DVec2 {
  double x = 0;
  double y = 0;
  DVec2(this.x, this.y);
}