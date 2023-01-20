import 'package:dm_helper/data/themes.dart';
import 'package:flutter/cupertino.dart';

class MapSelect extends StatelessWidget {
  String path;
  Function onPress;
  double size;
  double rim;
  bool selected;

  MapSelect({Key? key, required this.path, required this.onPress, required this.size, required this.rim, required this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(rim-1, rim, rim-1, rim),
      color: (selected)? MyThemes.primary : MyThemes.background,
      child: GestureDetector(
        onTap: () {
          onPress(path);
        },
        child: Image.asset(path, height: size, width: size,),
      ),
    );
  }
}