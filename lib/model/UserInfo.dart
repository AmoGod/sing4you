class UserInfo {
  int loginType;
  int code;
  Account account;
  Profile profile;
  List<Bindings> bindings;

  UserInfo(
      {this.loginType, this.code, this.account, this.profile, this.bindings});

  UserInfo.fromJson(Map<String, dynamic> json) {
    loginType = json['loginType'];
    code = json['code'];
    account =
        json['account'] != null ? new Account.fromJson(json['account']) : null;
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    if (json['bindings'] != null) {
      bindings = new List<Bindings>();
      json['bindings'].forEach((v) {
        bindings.add(new Bindings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginType'] = this.loginType;
    data['code'] = this.code;
    if (this.account != null) {
      data['account'] = this.account.toJson();
    }
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    if (this.bindings != null) {
      data['bindings'] = this.bindings.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Account {
  int id;
  String userName;
  int type;
  int status;
  int whitelistAuthority;
  int createTime;
  String salt;
  int tokenVersion;
  int ban;
  int baoyueVersion;
  int donateVersion;
  int vipType;
  int viptypeVersion;
  bool anonimousUser;

  Account(
      {this.id,
      this.userName,
      this.type,
      this.status,
      this.whitelistAuthority,
      this.createTime,
      this.salt,
      this.tokenVersion,
      this.ban,
      this.baoyueVersion,
      this.donateVersion,
      this.vipType,
      this.viptypeVersion,
      this.anonimousUser});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    type = json['type'];
    status = json['status'];
    whitelistAuthority = json['whitelistAuthority'];
    createTime = json['createTime'];
    salt = json['salt'];
    tokenVersion = json['tokenVersion'];
    ban = json['ban'];
    baoyueVersion = json['baoyueVersion'];
    donateVersion = json['donateVersion'];
    vipType = json['vipType'];
    viptypeVersion = json['viptypeVersion'];
    anonimousUser = json['anonimousUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['type'] = this.type;
    data['status'] = this.status;
    data['whitelistAuthority'] = this.whitelistAuthority;
    data['createTime'] = this.createTime;
    data['salt'] = this.salt;
    data['tokenVersion'] = this.tokenVersion;
    data['ban'] = this.ban;
    data['baoyueVersion'] = this.baoyueVersion;
    data['donateVersion'] = this.donateVersion;
    data['vipType'] = this.vipType;
    data['viptypeVersion'] = this.viptypeVersion;
    data['anonimousUser'] = this.anonimousUser;
    return data;
  }
}

class Profile {
  int avatarImgId;
  int backgroundImgId;
  int userType;
  int djStatus;
  bool mutual;
  Null remarkName;
  int authStatus;
  String backgroundUrl;
  String detailDescription;
  bool followed;
  String description;
  int userId;
  int vipType;
  int gender;
  String nickname;
  int accountStatus;
  int province;
  bool defaultAvatar;
  String avatarUrl;
  int birthday;
  int city;
  String avatarImgIdStr;
  String backgroundImgIdStr;
  String signature;
  int authority;
  int followeds;
  int follows;
  int eventCount;
  int playlistCount;
  int playlistBeSubscribedCount;

  Profile(
      {this.avatarImgId,
      this.backgroundImgId,
      this.userType,
      this.djStatus,
      this.mutual,
      this.remarkName,
      this.authStatus,
      this.backgroundUrl,
      this.detailDescription,
      this.followed,
      this.description,
      this.userId,
      this.vipType,
      this.gender,
      this.nickname,
      this.accountStatus,
      this.province,
      this.defaultAvatar,
      this.avatarUrl,
      this.birthday,
      this.city,
      this.avatarImgIdStr,
      this.backgroundImgIdStr,
      this.signature,
      this.authority,
      this.followeds,
      this.follows,
      this.eventCount,
      this.playlistCount,
      this.playlistBeSubscribedCount});

  Profile.fromJson(Map<String, dynamic> json) {
    avatarImgId = json['avatarImgId'];
    backgroundImgId = json['backgroundImgId'];
    userType = json['userType'];
    djStatus = json['djStatus'];
    mutual = json['mutual'];
    remarkName = json['remarkName'];
    authStatus = json['authStatus'];
    backgroundUrl = json['backgroundUrl'];
    detailDescription = json['detailDescription'];
    followed = json['followed'];
    description = json['description'];
    userId = json['userId'];
    vipType = json['vipType'];
    gender = json['gender'];
    nickname = json['nickname'];
    accountStatus = json['accountStatus'];
    province = json['province'];
    defaultAvatar = json['defaultAvatar'];
    avatarUrl = json['avatarUrl'];
    birthday = json['birthday'];
    city = json['city'];
    avatarImgIdStr = json['avatarImgIdStr'];
    backgroundImgIdStr = json['backgroundImgIdStr'];
    signature = json['signature'];
    authority = json['authority'];
    avatarImgIdStr = json['avatarImgId_str'];
    followeds = json['followeds'];
    follows = json['follows'];
    eventCount = json['eventCount'];
    playlistCount = json['playlistCount'];
    playlistBeSubscribedCount = json['playlistBeSubscribedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatarImgId'] = this.avatarImgId;
    data['backgroundImgId'] = this.backgroundImgId;
    data['userType'] = this.userType;
    data['djStatus'] = this.djStatus;
    data['mutual'] = this.mutual;
    data['remarkName'] = this.remarkName;
    data['authStatus'] = this.authStatus;
    data['backgroundUrl'] = this.backgroundUrl;
    data['detailDescription'] = this.detailDescription;
    data['followed'] = this.followed;
    data['description'] = this.description;
    data['userId'] = this.userId;
    data['vipType'] = this.vipType;
    data['gender'] = this.gender;
    data['nickname'] = this.nickname;
    data['accountStatus'] = this.accountStatus;
    data['province'] = this.province;
    data['defaultAvatar'] = this.defaultAvatar;
    data['avatarUrl'] = this.avatarUrl;
    data['birthday'] = this.birthday;
    data['city'] = this.city;
    data['avatarImgIdStr'] = this.avatarImgIdStr;
    data['backgroundImgIdStr'] = this.backgroundImgIdStr;
    data['signature'] = this.signature;
    data['authority'] = this.authority;
    data['avatarImgId_str'] = this.avatarImgIdStr;
    data['followeds'] = this.followeds;
    data['follows'] = this.follows;
    data['eventCount'] = this.eventCount;
    data['playlistCount'] = this.playlistCount;
    data['playlistBeSubscribedCount'] = this.playlistBeSubscribedCount;
    return data;
  }
}

class Bindings {
  int refreshTime;
  String url;
  int expiresIn;
  int userId;
  String tokenJsonStr;
  bool expired;
  int id;
  int type;

  Bindings(
      {this.refreshTime,
      this.url,
      this.expiresIn,
      this.userId,
      this.tokenJsonStr,
      this.expired,
      this.id,
      this.type});

  Bindings.fromJson(Map<String, dynamic> json) {
    refreshTime = json['refreshTime'];
    url = json['url'];
    expiresIn = json['expiresIn'];
    userId = json['userId'];
    tokenJsonStr = json['tokenJsonStr'];
    expired = json['expired'];
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refreshTime'] = this.refreshTime;
    data['url'] = this.url;
    data['expiresIn'] = this.expiresIn;
    data['userId'] = this.userId;
    data['tokenJsonStr'] = this.tokenJsonStr;
    data['expired'] = this.expired;
    data['id'] = this.id;
    data['type'] = this.type;
    return data;
  }
}
