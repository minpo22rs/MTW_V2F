import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mtw_project/models/hotel_model.dart';
import 'package:mtw_project/models/hotel_search_model.dart';
import 'package:mtw_project/models/room_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:http/http.dart' as http;
import 'package:mtw_project/views/basewidget/like_widget.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/hotels/hotel_detail_screen.dart';
import 'package:mtw_project/views/screens/hotels/hotel_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchHotel extends StatefulWidget {
  final String keyword, start, end, person;
  SearchHotel(
      {Key? key,
      required this.keyword,
      required this.start,
      required this.end,
      required this.person})
      : super(key: key);
  @override
  _SearchHotelState createState() =>
      _SearchHotelState(keyword, start, end, person);
}

class _SearchHotelState extends State<SearchHotel> {
  late String keyword, start, end, person;
  _SearchHotelState(this.keyword, this.start, this.end, this.person);
  List<HotelSearch> hotels = <HotelSearch>[];
  var resultHotel;
  List<RoomsChoose> rooms = <RoomsChoose>[];
  var resultData;
  searchHotel() async {
    var url = "https://mtwa.xyz/API/seacrh-hotel";
    var data = {
      'keyword': keyword,
      'start': start,
      'end': end,
      'person': person
    };
    await http.post(Uri.parse(url), body: data).then((value) {
      var result1 = jsonDecode(value.body);
      resultHotel = result1;

      hotels = <HotelSearch>[];
      for (var j = 0; j < resultHotel.length; j++) {
        HotelSearch d = HotelSearch.fromJson(resultHotel[j]);
        hotels.add(d);
      }
    });
    return hotels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () async {
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => HotelScreen(),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorResources.KTextBlack,
          ),
        ),
        title: Text(
          'โรงแรม',
          style: TextStyle(
            color: ColorResources.KTextBlack,
          ),
        ),
        backgroundColor: ColorResources.KTextWhite,
      ),
      body: FutureBuilder(
        future: searchHotel(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: ColorResources.KTextLightBlue,
                    ),
                  ],
                ),
              ),
            );
          }

          return Container(
            child: ListView.builder(
              itemCount: hotels.length,
              itemBuilder: (BuildContext context, int index) {
                if (rooms.length > 0) {
                  return Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: ColorResources.KTextLightBlue,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    child: Column(
                      children: [
                        FlatButton(
                          onPressed: () async {
                            var url = "https://mtwa.xyz/API/hotel-detail";
                            var data = {'hotel_id': '${hotels[index].id}'};
                            await http
                                .post(Uri.parse(url), body: data)
                                .then((response) {
                              var result = jsonDecode(response.body);
                              resultData = result['cr'];

                              if (response.statusCode == 200) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HotelDetailScreen(
                                      pKey: 'search',
                                      start: start,
                                      end: end,
                                      person: person,
                                      id: '${result['hotel']['id']}',
                                      name: '${result['hotel']['shopname']}',
                                      location:
                                          '${result['hotel']['position_url']}',
                                      image: '${result['hotel']['image']}',
                                      rating: '${result['hotel']['rating']}',
                                    ),
                                  ),
                                );
                              } else {
                                return;
                              }
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: 150.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              border: Border.all(width: 2, color: Colors.grey),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 105.sp,
                                  height: 175.sp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://mtwa.xyz/storage/app/public/seller/thumbnail/' +
                                            hotels[index].image,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 14,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 100.sp,
                                            // color: Colors.redAccent.withOpacity(0.2),
                                            child: Text(
                                              hotels[index].name,
                                              style: TextStyle(fontSize: 11.sp),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.sp,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              print('แชร์');
                                            },
                                            child: Icon(
                                              Icons.ios_share_rounded,
                                              color: ColorResources.ICON_Gray,
                                            ),
                                          ),
                                          LikeWidget(
                                            itemId: '${hotels[index].id}',
                                            type: 'H',
                                            color: 'LG',
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/location.svg',
                                            width: 13,
                                            height: 13,
                                            color: ColorResources.ICON_Red,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              launch(hotels[index].location);
                                            },
                                            child: Text(
                                              'สถานที่ตั้ง',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: ColorResources
                                                    .KTextLightBlue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Container(
                                          width: 60.sp,
                                          // color: Colors.black.withOpacity(0.2),
                                          child: StarWidget(
                                              sizestar: '10',
                                              sId: '${hotels[index].id}',
                                              type: 'hotel')),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            hotels[index].rating.toString() +
                                                '/5.00',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Container(
                                            width: 1,
                                            height: 13,
                                            color: Colors.black54,
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          if (double.parse(
                                                  hotels[index].rating) >=
                                              4.5) ...[
                                            Text(
                                              'ดีมาก',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color:
                                                    ColorResources.ICON_Green,
                                              ),
                                            ),
                                          ] else if (double.parse(
                                                  hotels[index].rating) >=
                                              4.00) ...[
                                            Text(
                                              'ดี',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color:
                                                    ColorResources.ICON_Green,
                                              ),
                                            ),
                                          ] else if (double.parse(
                                                  hotels[index].rating) >=
                                              3.00) ...[
                                            Text(
                                              'ปานกลาง',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color:
                                                    ColorResources.ICON_Yellow,
                                              ),
                                            ),
                                          ] else if (double.parse(
                                                  hotels[index].rating) >=
                                              2.00) ...[
                                            Text(
                                              'น้อย',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ] else if (double.parse(
                                                  hotels[index].rating) >=
                                              0.01) ...[
                                            Text(
                                              'ควรปรับปรุง',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: ColorResources.ICON_Red,
                                              ),
                                            ),
                                          ] else if (double.parse(
                                                  hotels[index].rating) <
                                              0.01) ...[
                                            Text(
                                              'ยังไม่มีการรีวิว',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: ColorResources.ICON_Red,
                                              ),
                                            ),
                                          ]
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
