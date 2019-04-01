import 'package:flutter/material.dart';
import '../model/UserInfo.dart';

class UserInfoProvide with ChangeNotifier {
  Account userinfo;
  List<Bindings> bindings = [];

  setUserInfo(Account info) {
    userinfo = info;
    notifyListeners();
  }

  setUserBindings(List<Bindings> list) {
    bindings = list;
    notifyListeners();
  }
}
