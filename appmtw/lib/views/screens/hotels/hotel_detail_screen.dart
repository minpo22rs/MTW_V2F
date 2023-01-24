import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/models/hotel_recent_seacrh.dart';
import 'package:mtw_project/models/seller_image_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/basewidget/image_slider_widget.dart';
import 'package:mtw_project/views/basewidget/like_widget.dart';
import 'package:mtw_project/views/basewidget/review_widget.dart';
import 'package:mtw_project/views/basewidget/search_widget.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/hotels/select_room.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelDetailScreen extends StatefulWidget {
  final String pKey, person, start, end, id, name, location, image, rating;
  const HotelDetailScreen({
    Key? key,
    required this.pKey,
    required this.person,
    required this.start,
    required this.end,
    required this.id,
    required this.name,
    required this.location,
    required this.image,
    required this.rating,
  }) : super(key: key);

  @override
  _HotelDetailScreenState createState() => _HotelDetailScreenState(
      pKey, person, start, end, id, name, location, image, rating);
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  late String pKey, person, start, end, id, name, location, image, rating;
  _HotelDetailScreenState(this.pKey, this.person, this.start, this.end, this.id,
      this.name, this.location, this.image, this.rating);

  @override
  void initState() {
    super.initState();
    if (pKey == 'search') {
      searchHoteh();
    }
  }

  void searchHoteh() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('hotelS', ['${id}']);
  }

  List<Sellerimg> images = <Sellerimg>[];
  var resultDataI;

  slideImage() async {
    var link = "https://mtwa.xyz/API/seller-images";
    var data = {
      'sId': '${id}',
    };
    await http.post(Uri.parse(link), body: data).then((value) {
      var result = jsonDecode(value.body);
      resultDataI = result;
      images = <Sellerimg>[];
      for (var i = 0; i < resultDataI.length; i++) {
        Sellerimg t = Sellerimg.fromJson(resultDataI[i]);
        images.add(t);
      }
    });
    return images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_outlined,
            color: ColorResources.ICON_Gray,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'โรงแรม',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 16,
          ),
          FutureBuilder(
            future: slideImage(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return ImageSlider(
                image: images,
                pageKey: 'hotels',
              );
            },
          ),
          SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      width: 60.sp,
                      // color: Colors.black.withOpacity(0.2),
                      child: StarWidget(
                          sizestar: '10', sId: '${id}', type: 'hotel'),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.ios_share_rounded,
                          color: ColorResources.ICON_Gray,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      LikeWidget(
                        itemId: '${id}',
                        type: 'H',
                        color: 'LG',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  rating + '/5.00',
                  style: TextStyle(
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Container(
                  width: 1,
                  height: 16,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 6,
                ),
                if (double.parse(rating) >= 4.5) ...[
                  Text(
                    'ดีมาก',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: ColorResources.ICON_Green,
                    ),
                  ),
                ] else if (double.parse(rating) >= 4.00) ...[
                  Text(
                    'ดี',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: ColorResources.ICON_Green,
                    ),
                  ),
                ] else if (double.parse(rating) >= 3.00) ...[
                  Text(
                    'ปานกลาง',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: ColorResources.ICON_Yellow,
                    ),
                  ),
                ] else if (double.parse(rating) >= 2.00) ...[
                  Text(
                    'น้อย',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.orange,
                    ),
                  ),
                ] else if (double.parse(rating) < 2.00) ...[
                  Text(
                    'ควรปรับปรุง',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: ColorResources.ICON_Red,
                    ),
                  ),
                ]
              ],
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/location.svg',
                  width: 16,
                  height: 16,
                  color: ColorResources.ICON_Red,
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    launch(location);
                  },
                  child: Text(
                    'เส้นทาง',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: ColorResources.KTextLightBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'เช็คอิน',
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        start,
                        style: TextStyle(color: Colors.cyan),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'เช็คเอาท์',
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        end,
                        style: TextStyle(color: Colors.cyan),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 6),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'จำนวนห้องและผู้เข้าพัก',
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '1 ห้อง : ผู้ใหญ่ ' + person + ' คน',
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Container(
              width: double.infinity,
              height: 180,
              // color: Colors.redAccent,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://mtwa.xyz/storage/app/public/seller/thumbnail/' +
                          image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 10),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/location.svg',
                  width: 16,
                  height: 16,
                  color: ColorResources.ICON_Red,
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    launch(location);
                  },
                  child: Text(
                    'เส้นทาง',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: ColorResources.KTextLightBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
          if (double.parse(rating) > 0) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('คะแนนโรงแรม'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 70.sp,
                            // color: Colors.black.withOpacity(0.2),

                            child: StarWidget(
                                sizestar: '13', sId: '${id}', type: 'hotel'),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(rating + '/5.00'),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
          ],
          ReviewWidget(sId: '${id}', type: 'H'),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: ColorResources.KTextLightBlue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectRoom(
                      hotelId: id,
                      title: name,
                      person: person,
                      start: start,
                      end: end,
                    ),
                  ),
                );
              },
              child: Text('เลือกห้องพัก'),
            ),
          ),
        ],
      ),
      // bottomNavigationBar:
    );
  }
}
