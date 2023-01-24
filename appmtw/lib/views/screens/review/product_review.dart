import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mtw_project/models/product_review.dart';
import 'package:mtw_project/models/review_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class ProductReview extends StatefulWidget {
  final String sId, type;
  const ProductReview({Key? key, required this.sId, required this.type})
      : super(key: key);

  @override
  _ProductReviewState createState() => _ProductReviewState(sId, type);
}

class _ProductReviewState extends State<ProductReview> {
  late String sId, type;
  _ProductReviewState(this.sId, this.type);
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
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: ColorResources.ICON_Black,
            ),
          ),
          title: Text(
            'รีวิวทั้งหมด',
            style: TextStyle(
              color: ColorResources.KTextBlack,
            ),
          ),
          backgroundColor: ColorResources.KTextWhite,
        ),
        body: FutureBuilder(
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
              children: [
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: reviewlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 22, top: 8, right: 22),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    'https://mtwa.xyz/storage/app/public/user/' +
                                        reviewlist[index].image,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      reviewlist[index].name,
                                      style: TextStyle(fontSize: 10.5.sp),
                                    ),
                                    SizedBox(height: 4),
                                    Container(
                                      // color: Colors.green,
                                      width: 45.sp,
                                      child: StarWidget(
                                        sizestar: '8',
                                        sId: '${reviewlist[index].id}',
                                        type: 'review',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              // color: Colors.amberAccent,
                              child: Column(
                                children: [
                                  Text(
                                    reviewlist[index].description,
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            )
                          ],
                        ),
                      );
                    }),
              ],
            );
          },
        ));
  }
}
