import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool pass;
  final TextEditingController? controller;

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
          left: 40,
          top: 12,
          right: 40,
          bottom: 12,
        ),
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
                fillColor: const Color.fromRGBO(0, 0, 0, 0.56),
                hintStyle: const TextStyle(color: Colors.white),
                hintText: hint,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(50),
                )
            )
        )
    );
  }
}