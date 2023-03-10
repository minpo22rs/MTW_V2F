import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mtw_project/models/vouchers_restaurant_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/restaurant/select_restaurant_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class RestaurantOther extends StatefulWidget {
  final List restaurants;
  const RestaurantOther({Key? key, required this.restaurants})
      : super(key: key);

  @override
  _RestaurantOtherState createState() => _RestaurantOtherState(restaurants);
}

class _RestaurantOtherState extends State<RestaurantOther> {
  late List restaurants;
  _RestaurantOtherState(this.restaurants);
  List<VouchersRes> vouchers = <VouchersRes>[];
  var resultData;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: (restaurants.length < 7) ? restaurants.length : 7,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: GestureDetector(
                onTap: () async {
                  var url = "https://mtwa.xyz/API/restaurant-detail";
                  var data = {'res_id': '${restaurants[index].id}'};
                  await http.post(Uri.parse(url), body: data).then((response) {
                    print('this response = ${response.body}');
                    var result = jsonDecode(response.body);
                    resultData = result['vr'];
                    vouchers = <VouchersRes>[];
                    for (var i = 0; i < resultData.length; i++) {
                      VouchersRes t = VouchersRes.fromJson(resultData[i]);
                      vouchers.add(t);
                    }
                    if (response.statusCode == 200) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectRestaurantScreen(
                                    id: '${result['restaurant']['id']}',
                                    name: '${result['restaurant']['shopname']}',
                                    image: '${result['restaurant']['image']}',
                                    location:
                                        '${result['restaurant']['position_url']}',
                                    open:
                                        '${result['restaurant']['open_time']}',
                                    close:
                                        '${result['restaurant']['close_time']}',
                                    vouchers: vouchers,
                                    rating: result['restaurant']['rating'],
                                  )));
                      print('object');
                    } else {
                      return;
                    }
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 90.sp,
                          height: 80.sp,
                          // color: Colors.redAccent.withOpacity(0.2),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://mtwa.xyz/storage/app/public/seller/thumbnail/' +
                                      restaurants[index].image,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 125.sp,
                              // color: Colors.redAccent.withOpacity(0.2),
                              child: Text(
                                restaurants[index].name,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            Text(
                              '????????????????????????????????????????????? ' + restaurants[index].address,
                              style: TextStyle(
                                fontSize: 7.5.sp,
                              ),
                            ),
                            Text(
                              '?????????????????????????????????',
                              style: TextStyle(
                                fontSize: 8.sp,
                              ),
                            ),
                            Text(
                              '????????????????????????-?????????',
                              style: TextStyle(
                                fontSize: 8.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '???????????????',
                          style: TextStyle(
                              fontSize: 8.sp, color: ColorResources.KTextBlack),
                        ),
                        Text(
                          restaurants[index].rating.toString(),
                          style: TextStyle(
                              fontSize: 10.5.sp,
                              color: ColorResources.KTextBlue),
                        ),
                        Container(
                            width: 35.sp,
                            // color: Colors.black.withOpacity(0.2),
                            child: StarWidget(
                                sizestar: '7',
                                sId: '${restaurants[index].id}',
                                type: 'restaurant'))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
