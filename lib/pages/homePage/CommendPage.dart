import 'package:flutter/material.dart';
import '../../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommendPage extends StatefulWidget {
  _CommendPageState createState() => _CommendPageState();
}

class _CommendPageState extends State<CommendPage> {
  List<Map> recommendList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: request('banner'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //snapshot就是_calculation在时间轴上执行过程的状态快照
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text(
                  'Press button to start'); //如果_calculation未执行则提示：请点击开始
            case ConnectionState.waiting:
              return new Text('Awaiting result...'); //如果_calculation正在执行则提示：加载中
            default: //如果_calculation执行完毕
              if (snapshot.hasError) //若_calculation执行出现异常
                return new Text('Error: ${snapshot.error}');
              else {
                //若_calculation执行正常完成
                var json = snapshot.data;
                return ListView(
                  children: <Widget>[
                    SwiperDiy(
                      swiperDataList: json['banners'],
                    ),
                    FloorItem(
                      tips: '每日推荐',
                    ),
                    RecommentSongs(),
                  ],
                );
              }
          }
        },
      ),
    );
  }
}

// banner 轮播图
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(300),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (context, int index) {
          return Image.network(
            '${swiperDataList[index]['imageUrl']}',
            fit: BoxFit.cover,
          );
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

// 楼层信息
class FloorItem extends StatelessWidget {
  final String tips;

  FloorItem({Key key, this.tips}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: InkWell(
        onTap: () {
          print('onTap');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              tips,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

// 每日推荐歌单
class RecommentSongs extends StatefulWidget {
  @override
  _RecommentSongsState createState() => _RecommentSongsState();
}

class _RecommentSongsState extends State<RecommentSongs> {
  List recommendList = [];

  @override
  void initState() {
    super.initState();
    getRecommentData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(350),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  Widget _item(int index) {
    return Container(
      height: ScreenUtil().setHeight(340),
      width: ScreenUtil().setWidth(250),
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          print('点击了');
        },
        child: Column(
          children: <Widget>[
            Image.network('${recommendList[index]['cover']}'),
            Text('${recommendList[index]['name']}'),
            Text('${recommendList[index]['artistName']}'),
          ],
        ),
      ),
    );
  }

  void getRecommentData() async {
    await request('top/mv').then((value) {
      print(value);
      setState(() {
        recommendList = value['data'];
      });
    });
  }
}
