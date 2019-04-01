import 'package:flutter/material.dart';
import './utils/User.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './utils/ShardPreferencesUser.dart';
import '../service/service_method.dart';
import '../model/UserInfo.dart';
import '../provide/UserInfo.dart';
import 'package:provide/provide.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey _globalKey = new GlobalKey();
  String _phone = ''; // 用户登录电话号码
  String _password = ''; // 密码
  bool _expand = false; // 是否展示历史账号列表
  List<User> _users = new List(); // 历史账号

  @override
  void initState() {
    super.initState();
    _gainUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          'SING4YOU',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(40),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: ScreenUtil().setWidth(500),
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Container(
                    height: ScreenUtil().setHeight(200),
                    child: Icon(
                      Icons.account_balance,
                      size: 30,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  _buildUserPhone(),
                  _buildPassword(),
                  _buildLoginButton(),
                  ShowAccount(),
                ],
              ),
            ),
          ),
          Offstage(
            child: _buildListView(),
            offstage: !_expand,
          ),
        ],
      ),
    );
  }

  // 账号输入框
  Widget _buildUserPhone() {
    return TextField(
      key: _globalKey,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8.0),
        prefixIcon: Icon(Icons.person_outline),
        suffixIcon: GestureDetector(
          onTap: () {
            if (_users.length > 1 || _users[0] != User(_phone, _password)) {
              // 如果个数大于1个 或者 唯一一个账号跟当前账号不一样才弹出历史账号
              setState(() {
                _expand = !_expand;
              });
            }
          },
          child: _expand
              ? Icon(
                  Icons.arrow_drop_up,
                  color: Colors.red,
                )
              : Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
        ),
      ),
      controller: TextEditingController.fromValue(
        TextEditingValue(
          text: _phone,
          selection: TextSelection.fromPosition(
            TextPosition(
              affinity: TextAffinity.downstream,
              offset: _phone == null ? 0 : _phone.length,
            ),
          ),
        ),
      ),
      onChanged: (value) {
        _phone = value;
      },
    );
  }

  // 构建密码输入框
  Widget _buildPassword() {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.all(8),
        ),
        controller: TextEditingController.fromValue(
          TextEditingValue(
            text: _password,
            selection: TextSelection.fromPosition(
              TextPosition(
                affinity: TextAffinity.downstream,
                offset: _password == null ? 0 : _password.length,
              ),
            ),
          ),
        ),
        onChanged: (value) {
          _password = value;
        },
        obscureText: true,
      ),
    );
  }

  // 构建历史账号 ListView
  Widget _buildListView() {
    if (_expand) {
      List<Widget> children = _buildItems();
      if (children.length > 0) {
        RenderBox renderObject = _globalKey.currentContext.findRenderObject();
        final position = renderObject.localToGlobal(Offset.zero);
        double screenW = MediaQuery.of(context).size.width;
        double currentW = renderObject.paintBounds.size.width;
        double currentH = renderObject.paintBounds.size.height;
        double margin = (screenW - currentW) / 2;
        double offsetY = position.dy;
        double itemHeight = 30.0;
        double dividerHeight = 2;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.blue, width: 2),
          ),
          child: ListView(
            itemExtent: itemHeight,
            padding: EdgeInsets.all(0),
            children: children,
          ),
          width: currentW,
          height: (children.length * itemHeight +
              (children.length - 1) * dividerHeight),
          margin: EdgeInsets.fromLTRB(margin, offsetY + currentH, margin, 0),
        );
      }
    }
    return null;
  }

  List<Widget> _buildItems() {
    List<Widget> list = new List();
    for (int i = 0; i < _users.length; i++) {
      if (_users[i] != User(_phone, _password)) {
        list.add(_buildItem(_users[i]));
        list.add(
          Divider(
            color: Colors.grey,
            height: 1,
          ),
        );
      }
    }
    if (list.length > 0) {
      list.removeLast();
    }
    return list;
  }

  Widget _buildItem(User user) {
    return GestureDetector(
      child: Container(
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(user.phone),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.highlight_off,
                  color: Colors.grey,
                ),
              ),
              onTap: () {
                setState(() {
                  _users.remove(user);
                  SharedPreferenceUserUtil.delUser(user);
                  // 处理最后一个数据 假如最后一个被删掉 将 expand 置为 false
                  if (!(_users.length > 1 ||
                      _users[0] != User(_phone, _password))) {
                    _expand = false;
                  }
                });
              },
            ),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          _phone = user.phone;
          _password = user.password;
          _expand = false;
        });
      },
    );
  }

  Widget _buildLoginButton() {
    return Container(
      padding: EdgeInsets.only(top: 30),
      width: double.infinity,
      child: FlatButton(
        onPressed: () {
          // 提交
          _login();
        },
        child: Text('登录'),
        color: Colors.pinkAccent,
        textColor: Colors.white,
      ),
    );
  }

  void _login() async {
    var data = {
      'phone': _phone,
      'password': _password,
    };
    await request('login/cellphone', formData: data).then((value) {
      if (value['code'] == 200) {
        Account account = Account.fromJson(value['account']);
        Provide.value<UserInfoProvide>(context).setUserInfo(account);
        SharedPreferenceUserUtil.saveUser(User(_phone, _password));
        SharedPreferenceUserUtil.addNoRepeat(_users, User(_phone, _password));
        Navigator.pop(context);
      }
    });
  }

  void _gainUsers() async {
    _users.clear();
    _users.addAll(await SharedPreferenceUserUtil.getUsers());

    if (_users.length > 0) {
      _phone = _users[0].phone;
      _password = _users[0].password;
    }
  }
}

class ShowAccount extends StatefulWidget {
  @override
  _ShowAccountState createState() => _ShowAccountState();
}

class _ShowAccountState extends State<ShowAccount> {
  @override
  Widget build(BuildContext context) {
    return Provide<UserInfoProvide>(
      builder: (context, child, data) {
        return Container(
          child:
              data.userinfo == null ? Text('暂无') : Text(data.userinfo.userName),
        );
      },
    );
  }
}
