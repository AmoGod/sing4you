import 'package:flutter/material.dart';
import './pages/MainPage.dart';

void main() => runApp(Sing4You());

class Sing4You extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sing4you',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}
