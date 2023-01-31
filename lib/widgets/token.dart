import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Token extends StatelessWidget {
  Color rim;
  String imgPath;
  double size;
  double rimWidth;
  Function? func;

  Token({Key? key, required this.rim, required this.imgPath, required this.size, required this.rimWidth, this.func}) : super(key: key);

  Image selectImage(String path) {
    if(path.startsWith("http")) {
      return Image.network(imgPath, fit: BoxFit.cover,);
    }
    return Image.asset(imgPath, fit: BoxFit.cover,);
    
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (func != null) {
          List<String> parts = imgPath.split("/");
          func!(parts[parts.length-1]);
        }
      },
      child: Container(
        padding: EdgeInsets.all(rimWidth),
        decoration: BoxDecoration(
            color: rim,
            shape: BoxShape.circle
        ),
        child: ClipOval(
          child: SizedBox.fromSize(
            size: Size.fromRadius(size/2),
            child: selectImage(imgPath),
          ),
        ),
      ),
    );
  }

}