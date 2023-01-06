import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:flutter/cupertino.dart';

class NewSessionPage extends StatefulWidget {
  const NewSessionPage({super.key});

  @override
  State<NewSessionPage> createState() => _NewSessionPage();
}

class _NewSessionPage extends State<NewSessionPage> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(title: "Add Session",),
        LoadingScreen(visible: false,),
      ],
    );
  }
}