import 'package:flutter/material.dart';

class MainWidget extends StatelessWidget {

  const MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: Container()),
    );
  }
}
