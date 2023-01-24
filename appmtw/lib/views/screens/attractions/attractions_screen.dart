import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/basewidget/button/custom_button.dart';
import 'package:mtw_project/views/basewidget/like_widget.dart';
import 'package:mtw_project/views/basewidget/search_widget.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/attractions/attraction_search.dart';
import 'package:mtw_project/views/screens/attractions/tab_attraction.dart';
import 'package:mtw_project/views/screens/hotels/hotel_listview_screen.dart';
import 'package:mtw_project/views/screens/pages/loading_attarction_screen.dart';
import 'package:mtw_project/views/screens/pages/loading_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class AttractionScreen extends StatefulWidget {
  final List attractions;
  final String banner;
  const AttractionScreen(
      {Key? key, required this.attractions, required this.banner})
      : super(key: key);

  @override
  _AttractionScreenState createState() =>
      _AttractionScreenState(attractions, banner);
}

class _AttractionScreenState extends State<AttractionScreen> {
  late List attractions;
  late String banner;
  _AttractionScreenState(this.attractions, this.banner);
  TextEditingController searchctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_outlined,
            color: ColorResources.ICON_Gray,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'สถานที่ท่องเที่ยว',
          style: TextStyle(color: Colors.black),
        ),
        // backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 8.0, bottom: 8, left: 15, right: 15),
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
                        hintText: 'ใส่ชื่อสถานที่หรือจังหวัดเพื่อทำการค้นหา',
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
                            builder: (BuildContext context) => AttracSearch(
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
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.only(left: 0, right: 0, top: 6, bottom: 6),
              width: double.infinity,
              height: 100.sp,
              color: Colors.amberAccent,
              child: Image.network(
                'https://mtwa.xyz/storage/app/public/banner/' + banner,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'สถานที่ท่องเที่ยวยอดฮิต',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => TacAttracScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'ทั้งหมด',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorResources.KTextLightBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            flex: 13,
            child: Container(
              width: double.infinity,
              child: ListView.builder(
                itemCount: attractions.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoadingAttractionScreen(
                                    pageKey: 'detail',
                                    productKey: '${attractions[index].id}',
                                  )));
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 130.sp,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://mtwa.xyz/storage/app/public/location/thumbnail/' +
                                                attractions[index].image),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 2,
                                    child: LikeWidget(
                                      itemId: '${attractions[index].id}',
                                      type: 'A',
                                      color: 'W',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 260.sp,
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
                                                  attractions[index].name,
                                                  style: TextStyle(
                                                      fontSize: 10.5.sp),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                      color: ColorResources
                                                          .ICON_Red,
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Expanded(
                                                      // width: 65.sp,
                                                      // color: Colors.amberAccent,
                                                      child: Text(
                                                        attractions[index]
                                                            .location,
                                                        style: TextStyle(
                                                            fontSize: 7.5.sp),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Container(
                                                  width: 110,
                                                  height: 25,
                                                  // color:
                                                  //     Colors.redAccent.withOpacity(0.4),
                                                  child: Text(
                                                    attractions[index]
                                                        .description,
                                                    style: TextStyle(
                                                        fontSize: 6.5.sp),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(),
                                          Column(
                                            children: [
                                              Text(
                                                attractions[index]
                                                    .rating
                                                    .toString(),
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
                                                    sId:
                                                        '${attractions[index].id}',
                                                    type: 'attrac',
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
