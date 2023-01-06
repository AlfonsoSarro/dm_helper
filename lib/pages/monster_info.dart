import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:flutter/cupertino.dart';

class MonsterInfoPage extends StatefulWidget {
  const MonsterInfoPage({super.key});

  @override
  State<MonsterInfoPage> createState() => _MonsterInfoPage();
}

class _MonsterInfoPage extends State<MonsterInfoPage> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(title: "<Name>",),
        LoadingScreen(visible: false,),
      ],
    );
  }
}