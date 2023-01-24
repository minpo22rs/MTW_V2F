import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtw_project/models/room_model.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/basewidget/button/custom_button.dart';
import 'package:mtw_project/views/screens/hotels/room_detail_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class RoomListView extends StatefulWidget {
  final String title, hotelId, person, start, end;
  const RoomListView(
      {Key? key,
      required this.title,
      required this.hotelId,
      required this.person,
      required this.start,
      required this.end})
      : super(key: key);

  @override
  _RoomListViewState createState() =>
      _RoomListViewState(title, hotelId, person, start, end);
}

class _RoomListViewState extends State<RoomListView> {
  late String title, hotelId, person, start, end;
  _RoomListViewState(
      this.title, this.hotelId, this.person, this.start, this.end);
  List<RoomsChoose> rooms = <RoomsChoose>[];
  var resultData;
  roomsSearch() async {
    var url = "https://mtwa.xyz/API/search-rooms";
    var data = {
      'hotel_id': '${hotelId}',
      'person': '${person}',
    };
    await http.post(Uri.parse(url), body: data).then((response) {
      var result = jsonDecode(response.body);
      resultData = result;
      rooms = <RoomsChoose>[];
      for (var i = 0; i < resultData.length; i++) {
        RoomsChoose t = RoomsChoose.fromJson(resultData[i]);
        rooms.add(t);
      }
    });
    return rooms;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: roomsSearch(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Container(
          child: ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.infinity,
                      height: 180.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        border: Border.all(width: 2, color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 100.sp,
                            height: 180.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://mtwa.xyz/storage/app/public/hotel/thumbnail/' +
                                      rooms[index].images,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 14,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      rooms[index].name,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                    Text(
                                      '${rooms[index].cancellation}',
                                      style: TextStyle(
                                        fontSize: 5.5.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'จำนวนคนเข้าพัก ' +
                                          '${rooms[index].person}' +
                                          ' คน',
                                      style: TextStyle(
                                        fontSize: 7.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'จำนวนเตียง ' +
                                          '${rooms[index].bed}' +
                                          ' เตียง',
                                      style: TextStyle(
                                        fontSize: 7.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'ขนาดห้อง ' + '${rooms[index].size}',
                                      style: TextStyle(
                                        fontSize: 7.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      width: 100,
                                      // color: Colors.red.withOpacity(0.2),
                                      child: Text(
                                        '${rooms[index].detail}',
                                        style: TextStyle(
                                          fontSize: 7.sp,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'ราคาสำหรับ 1 คืน',
                                      style: TextStyle(
                                        fontSize: 7.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      '${rooms[index].purchase_price}' + ' บาท',
                                      style: TextStyle(
                                        fontSize: 7.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'รวมภาษีและค่าธรรมเนียมแล้ว',
                                      style: TextStyle(
                                        fontSize: 5.5.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${rooms[index].prepaid}',
                                          style: TextStyle(
                                            fontSize: 4.5.sp,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Container(
                                            width: 42.w,
                                            height: 30,
                                            child: CustomButton(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RoomDetailScreen(
                                                      hotelId:
                                                          '${rooms[index].id}',
                                                      title: title,
                                                      start: start,
                                                      end: end,
                                                    ),
                                                  ),
                                                );
                                              },
                                              buttonText: 'เลือก',
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
