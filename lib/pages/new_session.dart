import 'dart:convert';

import 'package:dm_helper/control/cloud_storage.dart';
import 'package:dm_helper/widgets/background.dart';
import 'package:dm_helper/widgets/filled_button.dart';
import 'package:dm_helper/widgets/loading_screen.dart';
import 'package:dm_helper/widgets/mapSelect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../data/map-data.dart';
import '../data/themes.dart';
import '../widgets/custom_text_field.dart';
import 'home.dart';

class NewSessionPage extends StatefulWidget {
  const NewSessionPage({super.key});

  @override
  State<NewSessionPage> createState() => _NewSessionPage();
}

class _NewSessionPage extends State<NewSessionPage> {
  final double imgSize = 180;
  late String selectedPath;
  bool showError = false;
  String errText = "";
  Iterable<String> paths = [];
  Map<String, TextEditingController> textControllers = {
    "title": TextEditingController(),
    "desc": TextEditingController(),
  };

  void loadPaths() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final Iterable<String>paths = manifestMap.keys.where((String key) => key.contains("assets/maps/"));
    setState(() {
      this.paths = paths;
      this.selectedPath = paths.elementAt(0);
    });
  }

  void selectMap(String newPath) {
    setState(() {
      selectedPath = newPath;
    });
  }
  
  void createSession() async{
    if (textControllers["title"]!.text == "") {
      showErrorMessage("Error: the title must not be empty");
    }
    else {
      MapData data = MapData(textControllers["title"]!.text, textControllers["desc"]!.text, selectedPath);
      print(data.toJson());
      CloudStorage.uploadMap(data);
      Navigator.pushReplacement<void, void>(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const HomePage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          )
      );
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

  @override
  void initState() {
    loadPaths();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(
          title: "Add Session",
          goBack: true,
          child: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(CustomTextField.horizontalPadding, 0, CustomTextField.horizontalPadding, 0),
                          child: Align(alignment: Alignment.centerLeft,child: MyThemes.secondaryText("Title"),),
                        ),
                        CustomTextField(hint: "Title", controller: textControllers["title"],)
                      ],
                    ),
                  ),
                  Visibility(
                    visible: showError,
                    child: Text(errText, style: TextStyle(color: MyThemes.primary),),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(CustomTextField.horizontalPadding, 0, CustomTextField.horizontalPadding, 0),
                          child: Align(alignment: Alignment.centerLeft,child: MyThemes.secondaryText("Description"),),
                        ),
                        CustomTextField(hint: "Description", controller: textControllers["desc"], numLines: 5,)
                      ],
                    ),
                  ),
                  (paths.isNotEmpty)?
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    margin: EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Container(
                          color: MyThemes.separatorLine,
                          height: 1,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          width: MediaQuery.of(context).size.width *8/9,
                        ),
                        Container(
                          height: imgSize,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                              paths.length,
                                (i) {
                                    return MapSelect(
                                        path: paths.elementAt(i),
                                        onPress: selectMap,
                                        size: imgSize,
                                        rim: 2,
                                        selected: (selectedPath == paths.elementAt(i))
                                    );
                                }
                            ),
                          ),
                        ),
                        Container(
                          color: MyThemes.separatorLine,
                          height: 1,
                          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          width: MediaQuery.of(context).size.width *8/9,
                        )
                      ],
                    ),
                  ): Container(),
                  Container(
                    padding: EdgeInsets.only(
                      bottom: 30
                    ),
                    child: FilledButton(
                      text: MyThemes.primaryText("Create"),
                      colorBack: MyThemes.primary,
                      width: MediaQuery.of(context).size.width/3,
                      callback: createSession,
                    ),
                  )
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