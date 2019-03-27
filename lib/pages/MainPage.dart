import 'package:flutter/material.dart';

import './AssistantPage.dart';
import './HomePage.dart';
import './MinePage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController;
  int page = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: this.page,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          HomePage(),
          AssistantPage(),
          MinePage(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            title: Text('助手'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('我的'),
          ),
        ],
        onTap: onTap,
        currentIndex: page,
      ),
    );
  }

  void onTap(int index) {
    pageController.animateToPage(
      index,
      duration: Duration(
        milliseconds: 300,
      ),
      curve: Curves.ease,
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }
}
