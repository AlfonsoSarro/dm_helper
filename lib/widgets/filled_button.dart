import 'package:dm_helper/data/themes.dart';
import 'package:dm_helper/pages/login.dart';
import 'package:flutter/material.dart';

class FilledButton extends StatelessWidget {
  final Text text;
  final Color colorBack;
  final Widget pageToShow;
  final VoidCallback? callback;
  final double? width;

  //const FilledButton(this.text, this.colorBack, this.colorText, {super.key});
  const FilledButton({
    Key? key,
    required this.text,
    this.colorBack = Colors.white,
    this.pageToShow = const LoginPage(),
    this.callback,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: MyThemes.goldGradient,
        borderRadius: const BorderRadius.all(Radius.circular(50))
      ),
      padding: const EdgeInsets.fromLTRB(5, 0.8, 5, 0.8),
      child: TextButton(
        onPressed: () {
          if (callback == null) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => pageToShow));
          }
          else {
            callback!();
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
        child: text
      ),
    );
  }
}