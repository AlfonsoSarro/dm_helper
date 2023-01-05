import 'package:dm_helper/pages/login.dart';
import 'package:flutter/material.dart';

class FilledButton extends StatelessWidget {
  final String text;
  final Color colorBack;
  final Color colorText;
  final Widget pageToShow;
  final VoidCallback? callback;

  //const FilledButton(this.text, this.colorBack, this.colorText, {super.key});
  const FilledButton({
    Key? key,
    required this.text,
    this.colorBack = Colors.white,
    this.colorText = Colors.black,
    this.pageToShow = const LoginPage(title: 'Flutter Demo Home Page'),
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (callback == null) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => pageToShow));
        }
        else {
          callback;
        }
      },
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