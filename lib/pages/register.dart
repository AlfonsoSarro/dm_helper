// ignore_for_file: avoid_print

import 'package:dm_helper/control/authentication.dart';
import 'package:dm_helper/data/themes.dart';
import 'package:flutter/material.dart';
import '../widgets/filled_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}


class _RegisterPage extends State<RegisterPage> {
  bool showError = false;
  String errText = "";
  Map<String, TextEditingController> controllers = {
    "username": TextEditingController(),
    "email": TextEditingController(),
    "pass": TextEditingController(),
    "confirm": TextEditingController(),
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

  void registerFunc() async {
    int res = await AuthManager.register(controllers["username"]?.text, controllers["email"]?.text, controllers["pass"]?.text, controllers["confirm"]?.text);
    if (res == AuthManager.ok) {
      //Login Successful => route to home page
    }
    else {
      if (res == AuthManager.errFieldEmpty) {
        //Field Empty
        showErrorMessage("A field was empty");
      }
      else if (res == AuthManager.errPassMissMatch) {
        //Passwords don't match
        showErrorMessage("The passwords don't match");
      }
      else if (res == AuthManager.errEmailExist) {
        //Email already exists
        showErrorMessage("The email already exists");
      }
      else if (res == AuthManager.errWeakPass) {
        //The password is weak
        showErrorMessage("The password must be at least 6 characters");
      }
      else {
        showErrorMessage("Something went wrong");
      }
    }
  }

  @override
  void dispose() {
    for (var element in controllers.values) {element.dispose();}
    super.dispose();
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
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(15.0),
              children: <Widget>[
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/images/Logo.png'),
                      CustomTextField(
                        hint: "Username",
                        controller: controllers["username"],
                      ),
                      CustomTextField(
                        hint: "Email",
                        controller: controllers["email"],
                      ),
                      CustomTextField(
                        hint: "Password",
                        pass: true,
                        controller: controllers["pass"],
                      ),
                      CustomTextField(
                        hint: "Confirm Passowrd",
                        pass: true,
                        controller: controllers["confirm"],
                      ),
                      Visibility(
                          visible: showError,
                          child: Text(errText, style: const TextStyle(color: Color(0xe5ffd700)),),
                      ),
                      ButtonBar(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            FilledButton(
                              text: MyThemes.secondaryText("Login"),
                              colorBack: Color.fromRGBO(0, 0, 0, 1.0),
                              callback: () {Navigator.pop(context);},
                              width: (MediaQuery.of(context).size.width - (CustomTextField.horizontalPadding*2) - 10 - 30) / 2,
                            ),
                            FilledButton(
                              text: MyThemes.primaryText("Register"),
                              colorBack: const Color(0xe5ffd700),
                              callback: registerFunc,
                              width: (MediaQuery.of(context).size.width - (CustomTextField.horizontalPadding*2) - 10 - 30) / 2,
                            )
                          ]
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

        )
    );
  }
}


