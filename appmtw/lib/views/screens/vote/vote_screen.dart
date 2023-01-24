import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/categoryzone/category_zone_screen.dart';
import 'package:mtw_project/views/screens/pages/loading_screen.dart';
import 'package:mtw_project/views/screens/pages/widgets/rating_widget_line_one.dart';
import 'package:mtw_project/views/screens/pages/widgets/rating_widget_line_two.dart';
import 'package:mtw_project/views/screens/pages/widgets/rating_widget_one.dart';
import 'package:mtw_project/views/screens/pages/widgets/rating_widget_two.dart';
import 'package:mtw_project/views/screens/vote/vote_search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class VoteScreen extends StatefulWidget {
  final List onecon, twocon, onelinecon, twolinecon;
  final String wallet;
  const VoteScreen(
      {Key? key,
      required this.onecon,
      required this.twocon,
      required this.onelinecon,
      required this.twolinecon,
      required this.wallet})
      : super(key: key);
  @override
  _VoteScreenState createState() =>
      _VoteScreenState(onecon, twocon, onelinecon, twolinecon, wallet);
}

class _VoteScreenState extends State<VoteScreen> {
  late List onecon, twocon, onelinecon, twolinecon;
  late String wallet;
  _VoteScreenState(
      this.onecon, this.twocon, this.onelinecon, this.twolinecon, this.wallet);
  TextEditingController searchctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            final String? userId = prefs.getString('username');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LoadingScreen(
                          userid: '${userId}',
                        )));
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: ColorResources.ICON_Gray,
          ),
        ),
        title: Text(
          'Vote',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8, left: 15, right: 15),
              child: Container(
                height: 40.sp,
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        style: TextStyle(
                          fontSize: 13.0,
                          height: 0.9,
                          color: ColorResources.ICON_Light_Gray,
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100),
                        ],
                        controller: searchctrl,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              searchctrl.clear();
                            },
                            icon: Icon(Icons.clear),
                          ),
                          hintText: 'ใส่ชื่อนางงามหรือจังหวัดเพื่อทำการค้นหา',
                          hintStyle: TextStyle(color: ColorResources.KTextGray),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: ColorResources.KTextGray,
                              width: 1.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (searchctrl.text != '') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => VoteSearch(
                                searchKey: searchctrl.text,
                              ),
                            ),
                          );
                        }
                      },
                      child: Icon(Icons.search),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                "VOTE",
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            RatingWidgetOne(onecon: onecon),
            SizedBox(
              height: 10,
            ),
            RatingWidgetTwo(twocon: twocon),
            SizedBox(
              height: 10,
            ),
            RatingWidgetLineOne(onelinecon: onelinecon),
            SizedBox(
              height: 5,
            ),
            RatingWidgetLineTwo(twolinecon: twolinecon),
            SizedBox(
              height: 10,
            ),
            CategoryZoneScreen(
              wallet: wallet,
              pageKey: 'Screen',
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
