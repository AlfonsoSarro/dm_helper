import 'package:flutter/material.dart';
import 'widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  myFilledButton('Login'),
                  normalButton('Register'),
                  ]
            )
          ],
        ),
      ),

      )
    );
  }
}

Widget myFilledButton(String label) {
  return TextButton(
    onPressed: () { },
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )
      ),
      backgroundColor: MaterialStateProperty.all(const Color(0xe5ffd700)),
    ),
    child: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
      fontFamily: 'blackchancery',

      ),
    ),
  );
}

Widget normalButton(String label) {
  return TextButton(

    onPressed: () { },
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
          )
      ),
      backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(0, 0, 0, 0.56)),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'blackchancery',

      ),
    ),
  );
}