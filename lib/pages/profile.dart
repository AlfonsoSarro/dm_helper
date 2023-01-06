import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:flutter/cupertino.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(title: "Profile",),
        LoadingScreen(visible: false,),
      ],
    );
  }
}