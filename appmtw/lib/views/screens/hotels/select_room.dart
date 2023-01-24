import 'package:flutter/material.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/hotels/room_listview.dart';
import 'package:sizer/sizer.dart';

class SelectRoom extends StatefulWidget {
  final String hotelId, title, person, start, end;
  const SelectRoom(
      {Key? key,
      required this.hotelId,
      required this.title,
      required this.person,
      required this.start,
      required this.end})
      : super(key: key);

  @override
  _SelectRoomState createState() =>
      _SelectRoomState(title, hotelId, person, start, end);
}

class _SelectRoomState extends State<SelectRoom> {
  late String title, hotelId, person, start, end;
  _SelectRoomState(this.title, this.hotelId, this.person, this.start, this.end);
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
        title: Column(
          children: [
            Text(
              'เลือกห้องพัก',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 8.sp, color: Colors.black),
            ),
          ],
        ),
      ),
      body: RoomListView(
        hotelId: hotelId,
        person: person,
        title: title,
        start: start,
        end: end,
      ),
    );
  }
}
