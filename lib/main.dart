import 'package:flutter/material.dart';
import './pages/MainPage.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main() {
  runApp(Sing4You());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class Sing4You extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sing4you',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColorBrightness: Brightness.dark,
        splashColor: Colors.transparent,
      ),
      home: MainPage(),
    );
  }
}
