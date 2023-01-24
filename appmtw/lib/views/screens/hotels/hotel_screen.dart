import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtw_project/models/hotel_recent_seacrh.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/basewidget/button/custom_button.dart';
import 'package:mtw_project/views/basewidget/search_widget.dart';
import 'package:mtw_project/views/screens/hotels/hotel_listview_screen.dart';
import 'package:mtw_project/views/screens/hotels/search/hotel_search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HotelScreenState createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  @override
  void initState() {
    super.initState();
    searchHoteh();
    setState(() {
      selectedDate = DateTime.now();
      selectedDateEnd = DateTime.now().add(Duration(days: 1));
    });
  }

  void searchHoteh() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List? hotelS = prefs.getStringList('hotelS');
    print(hotelS);
  }

  DateTime selectedDate = DateTime.now();
  DateTime selectedDateEnd = DateTime.now().add(Duration(days: 1));
  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))))) {
      return true;
    }
    return false;
  }

  bool _decideWhichDayToEnableEnd(DateTime day) {
    if ((day.isAfter(selectedDateEnd.subtract(Duration(days: 1))))) {
      return true;
    }
    return false;
  }

  _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  _selectDateEnd(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePickerEnd(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePickerEnd(context);
    }
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
      helpText: 'เลือกวันเกิด',
      fieldLabelText: 'เลือกวันที่',
      fieldHintText: 'เดือน/วัน/ปี',
      cancelText: 'ยกเลิก',
      confirmText: 'ดำเนินการต่อ',
      selectableDayPredicate: _decideWhichDayToEnable,
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        selectedDateEnd = picked.add(Duration(days: 1));
      });
  }

  /// This builds cupertion date picker in iOS
  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: _decideWhichDayToEnable(selectedDate),
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != selectedDate)
                  setState(() {
                    selectedDate = picked;
                  });
              },
              initialDateTime: selectedDate,
              minimumYear: 1950,
              maximumYear: 2025,
            ),
          );
        });
  }

  buildMaterialDatePickerEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateEnd,
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
      helpText: 'เลือกวันเกิด',
      fieldLabelText: 'เลือกวันที่',
      fieldHintText: 'เดือน/วัน/ปี',
      cancelText: 'ยกเลิก',
      confirmText: 'ดำเนินการต่อ',
      selectableDayPredicate: _decideWhichDayToEnable,
    );
    if (picked != null && picked != selectedDateEnd)
      setState(() {
        selectedDateEnd = picked;
      });
  }

  /// This builds cupertion date picker in iOS
  buildCupertinoDatePickerEnd(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: _decideWhichDayToEnable(selectedDateEnd),
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != selectedDateEnd)
                  setState(() {
                    selectedDateEnd = picked;
                  });
              },
              initialDateTime: selectedDateEnd,
              minimumYear: 1950,
              maximumYear: 2025,
            ),
          );
        });
  }

  TextEditingController keywordctrl = TextEditingController();
  TextEditingController startctrl = TextEditingController();
  TextEditingController enddctrl = TextEditingController();
  TextEditingController personctrl = TextEditingController();
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
        // backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Container(
              height: 70,
              child: TextField(
                controller: keywordctrl,
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'ใกล้ตำแหน่งปัจจุบัน',
                  hintStyle: TextStyle(fontSize: 9.sp),
                ),
              ),
              // child: SearchWidget(hintText: 'ใกล้ตำแหน่งปัจจุบัน'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  height: 60,
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'เช็คอิน',
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  ("${selectedDate.toLocal()}".split(' ')[0])
                                          .split('-')[2] +
                                      '/' +
                                      ("${selectedDate.toLocal()}"
                                              .split(' ')[0])
                                          .split('-')[1] +
                                      '/' +
                                      ("${selectedDate.toLocal()}"
                                              .split(' ')[0])
                                          .split('-')[0],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  // child: SearchWidget(hintText: 'วว/ดด - วว/ดด/ปป'),
                ),
                SizedBox(
                  width: 20,
                  child: Text('ถึง'),
                ),
                Container(
                  width: 150,
                  height: 60,
                  child: GestureDetector(
                    onTap: () => _selectDateEnd(context),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'เช็คเอ้าท์',
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  ("${selectedDateEnd.toLocal()}".split(' ')[0])
                                          .split('-')[2] +
                                      '/' +
                                      ("${selectedDateEnd.toLocal()}"
                                              .split(' ')[0])
                                          .split('-')[1] +
                                      '/' +
                                      ("${selectedDateEnd.toLocal()}"
                                              .split(' ')[0])
                                          .split('-')[0],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  // child: SearchWidget(hintText: 'วว/ดด - วว/ดด/ปป'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Container(
              height: 70,
              child: TextField(
                controller: personctrl,
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'จำนวนคนเข้าที่พัก',
                  hintStyle: TextStyle(fontSize: 9.sp),
                ),
              ),
              // child: SearchWidget(hintText: 'จำนวนคนเข้าที่พัก'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomButton(
              buttonText: 'ค้นหา',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SearchHotel(
                        keyword: '${keywordctrl.text}',
                        start: ("${selectedDate.toLocal()}".split(' ')[0])
                                .split('-')[2] +
                            '/' +
                            ("${selectedDate.toLocal()}".split(' ')[0])
                                .split('-')[1] +
                            '/' +
                            ("${selectedDate.toLocal()}".split(' ')[0])
                                .split('-')[0],
                        end: ("${selectedDateEnd.toLocal()}".split(' ')[0])
                                .split('-')[2] +
                            '/' +
                            ("${selectedDateEnd.toLocal()}".split(' ')[0])
                                .split('-')[1] +
                            '/' +
                            ("${selectedDateEnd.toLocal()}".split(' ')[0])
                                .split('-')[0],
                        person: '${personctrl.text}'),
                  ),
                );
                var data = {
                  'keyword': '${keywordctrl.text}',
                  'start': "${selectedDate.toLocal()}".split(' ')[0],
                  'end': "${selectedDateEnd.toLocal()}".split(' ')[0],
                  'person': '${personctrl.text}'
                };
              },
              size: 50,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ประวัติการค้นหา',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         HotelListViewScreen(hotels: hotels),
                    //   ),
                    // );
                  },
                  child: Text(
                    'ดูทั้งหมด',
                    style: TextStyle(
                      fontSize: 8.5.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              height: 200.sp,
              decoration: BoxDecoration(
                // color: Colors.redAccent.withOpacity(0.2),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                border: Border.all(width: 2, color: Colors.grey),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 130.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(9),
                        topRight: Radius.circular(9),
                      ),
                      image: DecorationImage(
                        image: AssetImage(Images.bangkok),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 90.sp,
                              // color: Colors.amberAccent,
                              child: Text(
                                'ชื่อโรงแรม',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              'คะแนน',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'วว/ดด/ปป',
                              style: TextStyle(
                                fontSize: 8.sp,
                                color: Colors.black87,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                    color: ColorResources.KTextLightBlue,
                                  ),
                                ),
                                Container(
                                  width: 35.sp,
                                  // color: Colors.black.withOpacity(0.2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.circle_rounded,
                                        size: 5.sp,
                                        color: ColorResources.ICON_Yellow,
                                      ),
                                      Icon(
                                        Icons.circle_rounded,
                                        size: 5.sp,
                                        color: ColorResources.ICON_Yellow,
                                      ),
                                      Icon(
                                        Icons.circle_rounded,
                                        size: 5.sp,
                                        color: ColorResources.ICON_Yellow,
                                      ),
                                      Icon(
                                        Icons.circle_rounded,
                                        size: 5.sp,
                                        color: ColorResources.ICON_Yellow,
                                      ),
                                      Icon(
                                        Icons.circle_rounded,
                                        size: 5.sp,
                                        color: ColorResources.ICON_Light_Gray,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 35),
            child: Container(
              width: double.infinity,
              height: 110,
              // color: Colors.redAccent,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(9),
                //   topRight: Radius.circular(9),
                // ),
                image: DecorationImage(
                  image: AssetImage(Images.bangkok),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
