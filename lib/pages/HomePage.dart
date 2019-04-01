import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './homePage/CommendPage.dart';
import './homePage/LivePage.dart';
import './homePage/SongsPage.dart';

// 首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  List<Widget> tabs = [
    CommendPage(),
    SongsPage(),
    LivePage(),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 3,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: <Widget>[
            Tab(
              text: '推荐',
            ),
            Tab(
              text: '歌曲',
            ),
            Tab(
              text: '直播',
            ),
          ],
          controller: tabController,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: tabs,
      ),
    );
  }
}
