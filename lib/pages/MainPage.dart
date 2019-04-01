import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './utils/ShardPreferencesUser.dart';
import './utils/User.dart';
import '../service/service_method.dart';
import '../model/UserInfo.dart';
import '../provide/UserInfo.dart';
import 'package:provide/provide.dart';

import './HomePage.dart';
import './CirclePage.dart';
import './ReleasePage.dart';
import './CrowdfundPage.dart';
import './MinePage.dart';
import './LoginPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  PageController pageController;
  int page = 0;
  List<User> _users = new List();

  @override
  void initState() {
    super.initState();
    _gainUsers();
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
    // 填入设计稿中设备的屏幕尺寸
    // 默认 width : 1080px , height:1920px , allowFontScaling:false
    //  ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    // 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    //  ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    // 设置字体大小根据系统的“字体大小”辅助选项来进行缩放,默认为false : 字体随着系统的“字体大小”辅助选项来进行缩放
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
          ..init(context);

    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomePage(),
          CirclePage(),
          ReleasePage(),
          CrowdfundPage(),
          MinePage(),
        ],
        controller: pageController,
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        backgroundColor: Colors.white,
        foregroundColor: this.page == 2 ? Colors.pinkAccent : Colors.lightBlue,
        onPressed: () {
          onTap(2);
        },
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: bottomNavTabs(),
      ),
    );
  }

  Widget bottomNavTabs() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(150),
          child: IconButton(
            icon: Icon(Icons.music_note),
            color: this.page == 0 ? Colors.pinkAccent : Colors.lightBlue,
            onPressed: () {
              setState(() {
                onTap(0);
              });
            },
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(150),
          child: IconButton(
            icon: Icon(Icons.person_pin_circle),
            color: this.page == 1 ? Colors.pinkAccent : Colors.lightBlue,
            onPressed: () {
              setState(() {
                onTap(1);
              });
            },
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(150),
          child: Text(
            '*',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(150),
          child: IconButton(
            icon: Icon(Icons.people),
            color: this.page == 3 ? Colors.pinkAccent : Colors.lightBlue,
            onPressed: () {
              setState(() {
                onTap(3);
              });
            },
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(150),
          child: IconButton(
            icon: Icon(Icons.person),
            color: this.page == 4 ? Colors.pinkAccent : Colors.lightBlue,
            onPressed: () {
              setState(() {
                onTap(4);
              });
            },
          ),
        ),
      ],
    );
  }

  void onTap(int index) {
    setState(() {
      this.page = index;
    });
    pageController.jumpToPage(index);
  }

  // 获取历史用户
  void _gainUsers() async {
    _users.clear();
    _users.addAll(await SharedPreferenceUserUtil.getUsers());

    if (_users.length > 0) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String phone = sp.getString('phone0');
      String password = sp.getString('password0');
      var data = {
        'phone': phone,
        'password': password,
      };
      await request('login/cellphone', formData: data).then((value) {
        if (value['code'] == 200) {
          Account account = Account.fromJson(value['account']);
          Provide.value<UserInfoProvide>(context).setUserInfo(account);
        }
      });
    } else {
      Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context,
          Animation<double> animation, Animation<double> secondaryAnimation) {
        return LoginPage();
      }));
    }
  }
}
