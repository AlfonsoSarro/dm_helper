import 'package:dm_helper/data/themes.dart';
import 'package:flutter/material.dart';
import '../control/authentication.dart';
import '../widgets/filled_button.dart';
import '../widgets/custom_text_field.dart';
import 'home.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool showError = false;
  String errText = "";
  Map<String, TextEditingController> controllers = {
    "email": TextEditingController(),
    "pass": TextEditingController(),
  };

  void showErrorMessage (String msg) async{
    setState(() {
      errText = msg;
      showError = true;
    });
    await Future.delayed(Duration(seconds: 5));
    if (msg == errText) {
      setState(() {
        showError = false;
      });
    }
  }

  void loginFunc() async {
    int res = await AuthManager.login(controllers["email"]?.text, controllers["pass"]?.text);
    if (res == AuthManager.ok) {
      //Login Successful => route to home page
      Navigator.pushReplacement<void, void>(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const HomePage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          )
      );
    }
    else {
      if (res == AuthManager.errFieldEmpty) {
        //Field Empty
        showErrorMessage("A field was empty");
      }
      else if (res == AuthManager.errWrongPass) {
        //Passwords don't match
        showErrorMessage("Wrong Password");
      }
      else if (res == AuthManager.errNoExist) {
        //Email already exists
        showErrorMessage("The email doesn't exist");
      }
      else {
        showErrorMessage("Something went wrong");
      }
    }
  }

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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/Logo.png'),
                  CustomTextField(
                    hint: "Email",
                    controller: controllers["email"],
                  ),
                  CustomTextField(
                    hint: "Password",
                    pass: true,
                    controller: controllers["pass"],
                  ),
                  Visibility(
                    visible: showError,
                    child: Text(errText, style: TextStyle(color: MyThemes.primary),),
                  ),
                  ButtonBar(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FilledButton(
                          text: MyThemes.primaryText("Login"),
                          colorBack: MyThemes.primary,
                          callback: loginFunc,
                          width: (MediaQuery.of(context).size.width - (CustomTextField.horizontalPadding*2) - 10) / 2,
                        ),
                        FilledButton(
                          text: MyThemes.secondaryText("Register"),
                          colorBack: MyThemes.background,
                          pageToShow: RegisterPage(),
                          width: (MediaQuery.of(context).size.width - (CustomTextField.horizontalPadding*2) - 10) / 2,
                        )
                      ]
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}