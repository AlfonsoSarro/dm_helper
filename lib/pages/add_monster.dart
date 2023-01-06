import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:flutter/cupertino.dart';

class AddMonsterPage extends StatefulWidget {
  const AddMonsterPage({super.key});

  @override
  State<AddMonsterPage> createState() => _AddMonsterPage();
}

class _AddMonsterPage extends State<AddMonsterPage> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(title: "Add Entity",),
        LoadingScreen(visible: false,),
      ],
    );
  }
}