import 'dart:convert';

import 'package:dm_helper/control/authentication.dart';
import 'package:dm_helper/data/themes.dart';
import 'package:dm_helper/pages/login.dart';
import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/custom_text_field.dart';
import 'package:dm_helper/widgets/filled_button.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:dm_helper/widgets/token.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final double profileSize = 230;
  List<Widget>? profiles;
  Map<String, TextEditingController> textControllers = {
    "usr" : TextEditingController(),
    "oPass": TextEditingController(),
    "nPass": TextEditingController(),
    "cPass": TextEditingController(),
  };
  bool showError = false;
  String errText = "";

  void selectProfilePic(String profileName) async{
    await AuthManager.updatePhoto(profileName);
    loadProfiles();
  }

  void changePass() async{
    if (textControllers["oPass"]!.text == "" || textControllers["nPass"]!.text == "" || textControllers["cPass"]!.text == "") {
      showErrorMessage("Error: There are empty fields");
      return;
    }
    if (textControllers["nPass"]!.text != textControllers["cPass"]!.text) {
      showErrorMessage("Error: Passwords dont match");
      return;
    }
    else {
      int err = await AuthManager.changePass(textControllers["oPass"]!.text, textControllers["nPass"]!.text);
      if (err != AuthManager.ok) {
        switch (err) {
          case AuthManager.errWeakPass: {
            showErrorMessage("Error: Password must be at least 6 characters");
          }
          break;
          case AuthManager.errWrongPass:{
            showErrorMessage("Error: Incorrect original password");
          }
          break;
          default: {
            showErrorMessage("Error: Something went wrong");
          }
          break;
        }
      }
      else {
        textControllers["oPass"]!.text = "";
        textControllers["nPass"]!.text = "";
        textControllers["cPass"]!.text = "";
      }
      return;
    }
  }

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

  void loadProfiles() async {
    String profileName = "cleric1.jpg";
    try {
        profileName = AuthManager.currentUser.photoURL!;
    }
    catch (e) {}
    String userPath = "assets/tokens/profile/${profileName}";
    List<Token> tmpArr = [];
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final Iterable<String>paths = manifestMap.keys.where((String key) => key.contains("assets/tokens/profile/"));
    paths.forEach((element) {
      tmpArr.add(Token(
          rim: (userPath == element)? MyThemes.primary : Colors.black,
          imgPath: element,
          size: profileSize,
          rimWidth: 5,
          func: selectProfilePic,
      ));
    });

    setState(() {
      profiles = tmpArr;
    });
  }

  @override
  void initState() {
    textControllers["usr"]?.text = AuthManager.currentUser.displayName!;
    loadProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(
          title: "Profile",
          action: IconButton(
            icon: Icon(Icons.logout, color: Colors.white,),
            onPressed: () {
              AuthManager.logout();
              Navigator.pushReplacement<void,void>(context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => const LoginPage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  )
              );
            },
          ),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  (profiles != null) ? Container(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                    child: Column(
                      children: [
                        Container(
                          color: MyThemes.separatorLine,
                          height: 1,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          width: MediaQuery.of(context).size.width *8/9,
                        ),
                        Container(
                          height: profileSize,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: List.generate(profiles!.length,
                                    (index) => Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                  child: profiles![index],
                                  height: profileSize,
                                  width: profileSize,
                                )),
                          ),
                        ),
                        Container(
                          color: MyThemes.separatorLine,
                          height: 1,
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          width: MediaQuery.of(context).size.width *8/9,
                        )
                      ],
                    ),
                  ): Container(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(CustomTextField.horizontalPadding, 0, CustomTextField.horizontalPadding, 0),
                          child: Align(alignment: Alignment.centerLeft,child: MyThemes.secondaryText("Username"),),
                        ),
                        CustomTextField(hint: "Username", controller: textControllers["usr"],)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(CustomTextField.horizontalPadding, 0, CustomTextField.horizontalPadding, 0),
                          child: Align(alignment: Alignment.centerLeft,child: MyThemes.secondaryText("Password"),),
                        ),
                        CustomTextField(hint: "Old Password", pass: true, controller: textControllers["oPass"],),
                        CustomTextField(hint: "New Password", pass: true, controller: textControllers["nPass"],),
                        CustomTextField(hint: "Confirm Password", pass: true, controller: textControllers["cPass"],),
                        Visibility(
                          visible: showError,
                          child: Text(errText, style: TextStyle(color: MyThemes.primary),),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: FilledButton(
                              text: MyThemes.primaryText("Change"),
                              colorBack: MyThemes.primary,
                              callback: changePass,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        LoadingScreen(visible: false,),
      ],
    );
  }
}