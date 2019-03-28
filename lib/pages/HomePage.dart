import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
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
    getBannerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('听我唱'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            SwiperDiy(
              swiperDataList: swiper,
            ),
          ],
        ),
      ),
    );
  }

  void getBannerData() {
    request('banner').then((value) {
      if (value != null) {
        setState(() {
          this.swiper = (value['banners'] as List).cast();
          // print(this.swiper);
        });
      }
    });
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
