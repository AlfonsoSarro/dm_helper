import 'package:flutter/material.dart';
import 'widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/Background.png'),
                fit: BoxFit.cover
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/Logo.png'),
                const CustomTextField("Username", false),
                const CustomTextField("Email", false),
                const CustomTextField("Password", true),
                const CustomTextField("Confirm password", true),
                const ButtonBar(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FilledButton(
                          'Register', Color(0xe5ffd700), Color(0xFF000000)),
                    ]
                )
              ],
            ),
          ),

        )
    );
  }
}


