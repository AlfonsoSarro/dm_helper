import 'package:dm_helper/data/monster-data.dart';
import 'package:dm_helper/data/vec2.dart';
import 'package:flutter/cupertino.dart';

class DragData {
  MonsterData data;
  Widget token;

  DragData(this.data, this.token);
}