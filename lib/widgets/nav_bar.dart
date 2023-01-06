import 'package:dm_helper/pages/home.dart';
import 'package:dm_helper/pages/new_session.dart';
import 'package:dm_helper/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {

  void navigateHome(BuildContext context) {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const HomePage(),
      ),
    );
  }
  void navigateNewSession(BuildContext context) {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const NewSessionPage(),
      ),
    );
  }
  void navigateProfile(BuildContext context) {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const ProfilePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(160, 0, 0, 0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Color.fromARGB(255, 218, 165, 32),
              height: 1.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: IconButton(
                    onPressed: () {
                      navigateHome(context);
                    },
                    icon: Image.asset("assets/images/Castle.png",)
                ),
              ),
              SizedBox(
                width: 70,
                height: 70,
                child: IconButton(
                    onPressed: () {
                      navigateNewSession(context);
                    },
                    icon: Image.asset("assets/images/AddSession.png",)
                ),
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: IconButton(
                    onPressed: () {
                      navigateProfile(context);
                    },
                    icon: Image.asset("assets/images/Knight.png",)
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}