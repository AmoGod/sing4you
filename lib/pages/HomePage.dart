import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map> swiper = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('听我唱'),
      ),
      body: FutureBuilder(
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
                  ],
                );
              }
          }
        },
      ),
      // body: Container(
      //   child: ListView(
      //     children: <Widget>[
      //       SwiperDiy(
      //         swiperDataList: swiper,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

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
