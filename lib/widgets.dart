import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool pass;

  const CustomTextField(this.hint, this.pass, {super.key});

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

class FilledButton extends StatelessWidget {
  final String text;
  final Color colorBack;
  final Color? colorText;

  const FilledButton(this.text, this.colorBack, this.colorText, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () { },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )
        ),
        backgroundColor: MaterialStateProperty.all(colorBack),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: colorText,
          fontFamily: 'blackchancery',

        ),
      ),
    );
  }
}