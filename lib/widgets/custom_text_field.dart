import 'package:flutter/material.dart';
import '../data/themes.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool pass;
  final TextEditingController? controller;
  static const double horizontalPadding = 40;
  static const double verticalPadding = 12;

  //const CustomTextField(this.hint, this.pass, {super.key});
  const CustomTextField({
    Key? key,
    this.hint = "Text",
    this.pass = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          left: horizontalPadding,
          top: verticalPadding,
          right: horizontalPadding,
          bottom: verticalPadding,
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: MyThemes.goldGradient,
              borderRadius: const BorderRadius.all(Radius.circular(50))
          ),
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: TextField(
              controller: controller,
              style: const TextStyle(
                  color: Colors.white
              ),

              obscureText: pass,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      left: 20,
                      right: 20
                  ),
                  filled: true,
                  fillColor: const Color.fromRGBO(0, 0, 0, 1),
                  hintStyle: const TextStyle(color: Colors.white),
                  hintText: hint,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50),
                  )
              )
          ),
        )
    );
  }
}