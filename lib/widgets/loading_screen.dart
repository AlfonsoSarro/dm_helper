import 'package:flutter/cupertino.dart';

class LoadingScreen extends StatelessWidget {
  bool visible;
  LoadingScreen({
    Key? key,
    required this.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/Background.png'),
                fit: BoxFit.cover
            )
        ),
        child: Container(
          child: Align(
            alignment: Alignment.center,
            child: Image.asset('assets/images/Logo.png'),
          ),
        ),
      ),
    );
  }
}