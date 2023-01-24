import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mtw_project/models/review_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/review/product_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class ReviewWidget extends StatefulWidget {
  final String sId, type;
  ReviewWidget({Key? key, required this.sId, required this.type})
      : super(key: key);
  @override
  _ReviewWidgetState createState() => _ReviewWidgetState(sId, type);
}

class _ReviewWidgetState extends State<ReviewWidget> {
  late String sId, type;
  _ReviewWidgetState(this.sId, this.type);
  List<ReviewM> reviewlist = <ReviewM>[];
  var resultDataR;
  reviewList() async {
    var link = "https://mtwa.xyz/API/reviewlist";
    var review = {
      'sId': sId,
      'type': type,
    };
    await http.post(Uri.parse(link), body: review).then((value) {
      var result = jsonDecode(value.body);
      resultDataR = result;
      reviewlist = <ReviewM>[];
      for (var j = 0; j < resultDataR.length; j++) {
        ReviewM d = ReviewM.fromJson(resultDataR[j]);
        reviewlist.add(d);
      }
    });
    return reviewlist;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: reviewList(),
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
                if (reviewlist.length > 0) ...[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'รีวิวจากผู้ใช้',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ProductReview(
                                  sId: sId,
                                  type: type,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'ดูทั้งหมด',
                            style: TextStyle(
                              color: ColorResources.KTextLightBlue,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: (reviewlist.length > 0) ? 200 : 100,
                  child: ListView.builder(
                    itemCount: (reviewlist.length < 6) ? reviewlist.length : 5,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                      'https://mtwa.xyz/storage/app/public/user/' +
                                          reviewlist[index].image),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(reviewlist[index].name),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Container(
                                      width: 50.sp,
                                      // color: Colors.black.withOpacity(0.2),
                                      child: StarWidget(
                                        sizestar: '10',
                                        sId: '${reviewlist[index].id}',
                                        type: 'review',
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 60, vertical: 8),
                            child: Container(
                              width: double.infinity,
                              // color: Colors.redAccent.withOpacity(0.2),
                              child: Text(
                                reviewlist[index].description,
                              ),
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
            );
          },
        ),
      ],
    );
  }
}
