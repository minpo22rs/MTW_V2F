import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mtw_project/models/hotel_model.dart';
import 'package:mtw_project/models/room_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/basewidget/like_widget.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/hotels/hotel_detail_screen.dart';
import 'package:mtw_project/views/screens/hotels/popular_hotel_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class PopularHotelScreen extends StatefulWidget {
  const PopularHotelScreen({Key? key}) : super(key: key);
  @override
  _PopularHotelScreenState createState() => _PopularHotelScreenState();
}

class _PopularHotelScreenState extends State<PopularHotelScreen> {
  List<RoomsChoose> rooms = <RoomsChoose>[];
  bool favorite = false;
  var resultData;
  DateTime start = DateTime.now();
  DateTime end = DateTime.now().add(Duration(days: 2));
  @override
  void initState() {
    super.initState();
    // recHotel().whenComplete(() {
    //   setState(() {});
    // });
  }

  List<Hotel> hotels = <Hotel>[];
  var resultHotel;
  bool statusData = false;

  recHotel() async {
    var url = "https://mtwa.xyz/API/recommend-hotel";
    await http.get(Uri.parse(url)).then((response) {
      var result1 = jsonDecode(response.body);
      resultHotel = result1;
      hotels = <Hotel>[];
      for (var j = 0; j < resultHotel.length; j++) {
        Hotel d = Hotel.fromJson(resultHotel[j]);
        hotels.add(d);
      }
    });
    return hotels;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 190,
      // color: Colors.red.withOpacity(0.2),
      child: FutureBuilder(
        future: recHotel(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hotels.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    var url = "https://mtwa.xyz/API/hotel-detail";
                    var data = {'hotel_id': '${hotels[index].id}'};
                    await http
                        .post(Uri.parse(url), body: data)
                        .then((response) {
                      var result = jsonDecode(response.body);

                      if (response.statusCode == 200) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HotelDetailScreen(
                              pKey: 'popu',
                              id: '${result['hotel']['id']}',
                              name: '${result['hotel']['shopname']}',
                              location: '${result['hotel']['position_url']}',
                              image: '${result['hotel']['image']}',
                              rating: '${result['hotel']['rating']}',
                              start: ("${start.toLocal()}".split(' ')[0])
                                      .split('-')[2] +
                                  '/' +
                                  ("${start.toLocal()}".split(' ')[0])
                                      .split('-')[1] +
                                  '/' +
                                  ("${start.toLocal()}".split(' ')[0])
                                      .split('-')[0],
                              end: ("${end.toLocal()}".split(' ')[0])
                                      .split('-')[2] +
                                  '/' +
                                  ("${end.toLocal()}".split(' ')[0])
                                      .split('-')[1] +
                                  '/' +
                                  ("${end.toLocal()}".split(' ')[0])
                                      .split('-')[0],
                              person: '1',
                            ),
                          ),
                        );
                      } else {
                        return;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 130.sp,
                                  height: 95.sp,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://mtwa.xyz/storage/app/public/seller/thumbnail/' +
                                              hotels[index].image),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 2,
                                  child: LikeWidget(
                                    itemId: '${hotels[index].id}',
                                    type: 'A',
                                    color: 'W',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 130.sp,
                                  height: 70.sp,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: 85.sp,
                                          height: 53.sp,
                                          // color: Colors.redAccent.withOpacity(0.2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                hotels[index].name,
                                                style: TextStyle(
                                                    fontSize: 10.5.sp),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/location.svg',
                                                    width: 14,
                                                    height: 14,
                                                    color:
                                                        ColorResources.ICON_Red,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Expanded(
                                                    // width: 65.sp,
                                                    // color: Colors.amberAccent,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        launch(hotels[index]
                                                            .location);
                                                      },
                                                      child: Text(
                                                        'สถานที่ตั้ง',
                                                        style: TextStyle(
                                                            color: ColorResources
                                                                .KTextLightBlue,
                                                            fontSize: 7.5.sp),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              // Container(
                                              //   width: 110,
                                              //   height: 25,
                                              //   // color:
                                              //   //     Colors.redAccent.withOpacity(0.4),
                                              //   child: Text(
                                              //     hotels[index].description,
                                              //     style: TextStyle(
                                              //         fontSize: 6.5.sp),
                                              //     overflow:
                                              //         TextOverflow.ellipsis,
                                              //     maxLines: 2,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              hotels[index].rating.toString(),
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue[900],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Container(
                                                width: 35.sp,
                                                // color: Colors.black.withOpacity(0.2),
                                                child: StarWidget(
                                                  sizestar: '7',
                                                  sId: '${hotels[index].id}',
                                                  type: 'hotel',
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
