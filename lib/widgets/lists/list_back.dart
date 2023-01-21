import 'package:flutter/cupertino.dart';

class ListBack extends StatelessWidget {
  double height;
  double width;
  Widget? child;
  ListBack({Key? key, this.child, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            width: width,
            height: height,
            child: Container(
              width: width,
              height: height * 8/9,
              color: Color.fromRGBO(0, 0, 0, 0.5),
            ),
          ),
          Container(
            width: width,
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/gold-royal-flower-left.png", height: height,),
                (child != null)? child! : Container(),
                Image.asset("assets/images/gold-royal-flower-right.png", height: height,),
              ],
            ),
          )
        ],
      ),
    );
  }
}