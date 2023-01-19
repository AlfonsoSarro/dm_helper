import 'package:dm_helper/data/themes.dart';
import 'package:dm_helper/widgets/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  Widget? child;
  String title;
  bool goBack;
  Widget? action;

  Background({Key? key, required this.title, this.child, this.goBack = false, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox.expand(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Background.png'),
                    fit: BoxFit.cover
                )
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Container(
                color: MyThemes.separatorLine,
                height: 1.0,
              ),
            ),
            backgroundColor: Color.fromARGB(160, 0, 0, 0),
            centerTitle: true,
            foregroundColor: Colors.white,
            title: Text(title,
              style: TextStyle(
                fontFamily: 'blackchancery',
                fontSize: 40
              ),
            ),
            leading: goBack? IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ): Container(),
            actions: [(action != null)? action! : Container()],
          ),
          body: child,
          bottomNavigationBar: NavBar(),
        )
      ],
    );
  }
}