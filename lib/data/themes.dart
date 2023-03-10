import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyThemes {
  static LinearGradient goldGradient = const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: <Color>[
      Color(0xe5DAA520),
      Color(0xe5FFD700),
      Color(0xe5FFFFFF),
      Color(0xe5FFD700),
      Color(0xe5DAA520),
      Color(0xe5FFD700),
      Color(0xe5FFFFFF),
      Color(0xe5FFD700),
      Color(0xe5DAA520),
    ]
  );
  
  static Color primary = const Color(0xe5FFD700);
  static Color separatorLine = const Color.fromARGB(255, 218, 165, 32);

  static Color background = const Color.fromRGBO(0, 0, 0, 1.0);

  static Text primaryText(String text) => Text(
    text,
    style: TextStyle(
      color: Colors.black,
      fontFamily: 'blackchancery',
      fontSize: 20,
      overflow: TextOverflow.ellipsis,
    ),
  );

  static Text primaryTextSizeable(String text, double size) => Text(
    text,
    style: TextStyle(
      color: Colors.black,
      fontFamily: 'blackchancery',
      fontSize: size,
    ),
  );

  static Text secondaryText(String text) => Text(
    text,
    style: TextStyle(
      color: Colors.white,
      fontFamily: 'blackchancery',
      fontSize: 20,
    ),
    overflow: TextOverflow.ellipsis,
  );

  static Text secondaryTextSizeable(String text, double size) => Text(
    text,
    style: TextStyle(
      color: Colors.white,
      fontFamily: 'blackchancery',
      fontSize: size,
    ),
  );

  static Text secondaryTextMultiline(String text) => Text(
    text,
    style: TextStyle(
      color: Colors.white,
      fontFamily: 'inter',
      fontSize: 20,
    ),
    overflow: TextOverflow.clip,
  );
}