import 'package:flutter/material.dart';
import '../pages/LoginPage.dart';

// 我的
class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: Center(
        child: FlatButton(
          child: Text('登录'),
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return LoginPage();
            }));
          },
        ),
      ),
    );
  }
}
