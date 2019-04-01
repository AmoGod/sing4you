class User {
  String _phone;
  String _password;

  User(this._phone, this._password);

  get phone => _phone;
  get password => _password;

  @override
  String toString() {
    return "|$_phone $_password|";
  }

  @override
  bool operator ==(other) {
    return (_phone == other._phone) && (_password == other._password);
  }
}
