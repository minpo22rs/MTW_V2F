import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mtw_project/models/attraction_model.dart';
import 'package:mtw_project/views/basewidget/like_widget.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/pages/loading_attarction_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class ContentMem extends StatefulWidget {
  final String mId;
  ContentMem({Key? key, required this.mId}) : super(key: key);
  @override
  _ContentMemState createState() => _ContentMemState(mId);
}

class _ContentMemState extends State<ContentMem> {
  late String mId;
  _ContentMemState(this.mId);
  List<Attraction> attraction = <Attraction>[];
  var resultA;
  content() async {
    var link = "https://mtwa.xyz/API/attraction-member-detail";
    var data = {
      'mId': mId,
    };
    await http.post(Uri.parse(link), body: data).then((value) {
      var result = jsonDecode(value.body);
      resultA = result;
      attraction = <Attraction>[];
      for (var j = 0; j < resultA.length; j++) {
        Attraction d = Attraction.fromJson(resultA[j]);
        attraction.add(d);
      }
    });
    return attraction;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: content(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (attraction.length > 0) ...[
              Text(
                'สถาที่ท่องเที่ยวที่แนะนำ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp,
                ),
              ),
              Divider(
                thickness: 0.5,
              ),
              Container(
                height: 150,
                child: ListView.builder(
                  itemCount: attraction.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoadingAttractionScreen(
                                  pageKey: 'detail',
                                  productKey: '${attraction[index].id}',
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 104.sp,
                                    height: 80.sp,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://mtwa.xyz/storage/app/public/location/thumbnail/' +
                                                attraction[index].image),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15.sp,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(attraction[index].name),
                                  Container(
                                    width: 35.sp,
                                    child: StarWidget(
                                      sizestar: '7',
                                      sId: '${attraction[index].id}',
                                      type: 'attrac',
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
