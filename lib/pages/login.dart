import 'package:flutter/material.dart';
import '../widgets/filled_button.dart';
import '../widgets/custom_text_field.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
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
                const CustomTextField("Password", true),
                const ButtonBar(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FilledButton(text: 'Login',
                        colorBack: Color(0xe5ffd700),
                        colorText: Color(0xFF000000),
                        pageToShow: LoginPage(title: "Flutter Demo"),
                      ),
                      FilledButton(text: "Register",
                        colorBack: Color.fromRGBO(0, 0, 0, 0.56),
                        colorText: Color(0xFFFFFFFF),
                        pageToShow: RegisterPage(),
                      )
                    ]
                )
              ],
            ),
          ),

        )
    );
  }
}