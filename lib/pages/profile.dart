import 'package:dm_helper/data/themes.dart';
import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:dm_helper/widgets/token.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        Background(
          title: "Profile",
          child: Container(
            child: Column(
              children: [
                Token(
                    rim: Colors.black,
                    imgPath: "assets/tokens/profile/fighter1.png",
                    size: 300,
                    rimWidth: 10)
              ],
            ),
          ),
        ),
        LoadingScreen(visible: false,),
      ],
    );
  }
}