import 'package:flutter/material.dart';

// 圈子

class CirclePage extends StatefulWidget {
  @override
  _CirclePageState createState() => _CirclePageState();
}

class _CirclePageState extends State<CirclePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('圈子'),
      ),
      body: Center(
        child: Text('456'),
      ),
    );
  }
}
