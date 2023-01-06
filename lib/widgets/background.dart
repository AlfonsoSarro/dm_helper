import 'package:dm_helper/widgets/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  Widget? child;
  String title;

  Background({Key? key, required this.title, this.child}) : super(key: key);

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
                color: Color.fromARGB(255, 218, 165, 32),
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
          ),
          body: child,
          bottomNavigationBar: NavBar(),
        )
      ],
    );
  }
}