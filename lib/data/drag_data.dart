import 'package:dm_helper/data/vec2.dart';
import 'package:flutter/cupertino.dart';

class DragData {
  Vec2 coords;
  Widget token;
  var clearContent;

  DragData(this.coords, this.token, this.clearContent);
}