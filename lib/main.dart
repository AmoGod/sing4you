import 'package:flutter/material.dart';
import './pages/MainPage.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:provide/provide.dart';

import './provide/Counter.dart';
import './provide/UserInfo.dart';

void main() {
  var counter = Counter();
  var userInfoProvide = UserInfoProvide();
  var providers = Providers();

  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<UserInfoProvide>.value(userInfoProvide));

  runApp(
    ProviderNode(
      child: Sing4You(),
      providers: providers,
    ),
  );
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
