import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
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
                  //TODO add route to the Home page
                    onPressed: () {},
                    icon: Image.asset("assets/images/Castle.png",)
                ),
              ),
              SizedBox(
                width: 70,
                height: 70,
                child: IconButton(
                  //TODO add route to add session page
                    onPressed: () {},
                    icon: Image.asset("assets/images/AddSession.png",)
                ),
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: IconButton(
                  //TODO add route to profile
                    onPressed: () {},
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