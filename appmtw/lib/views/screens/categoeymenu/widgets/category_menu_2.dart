import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/pages/loading_attarction_screen.dart';
import 'package:mtw_project/views/screens/restaurant/restautant_screen.dart';
import 'package:mtw_project/views/screens/sos/sos_screen.dart';
import 'package:sizer/sizer.dart';

class CategoryMenuWidget2 extends StatelessWidget {
  final List restaurants, categoryrestaurants;
  final String bannersub;
  CategoryMenuWidget2(
      {Key? key,
      required this.restaurants,
      required this.categoryrestaurants,
      required this.bannersub})
      : super(key: key);
  TextStyle mystyle =
      TextStyle(fontSize: 9.sp, color: ColorResources.KTextPink);

  void _toast(var module) {
    Fluttertoast.showToast(
        msg: "พบกับบริการ " + module + " เร็วๆนี้",
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              IconButton(
                splashRadius: 1,
                icon: SvgPicture.asset(
                  'assets/icons/car (1).svg',
                  width: 14.sp,
                  height: 17.sp,
                  color: ColorResources.KTextPink,
                ),
                onPressed: () {
                  _toast('เช่ารถ');
                },
              ),
              Text(
                "เช่ารถ",
                style: mystyle,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/fast-food.svg',
                  width: 14.sp,
                  height: 17.sp,
                  color: ColorResources.KTextPink,
                ),
                onPressed: () {
                  // _toast('ร้านอาหาร');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => RestaurantScreen(
                            restaurants: restaurants,
                            categoryrestaurants: categoryrestaurants,
                            bannersub: bannersub)),
                  );
                },
              ),
              Text(
                "ร้านอาหาร",
                style: mystyle,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/map.svg',
                  width: 14.sp,
                  height: 17.sp,
                  color: ColorResources.KTextPink,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoadingAttractionScreen(
                                pageKey: 'screen',
                                productKey: '',
                              )));
                },
              ),
              Column(
                children: [
                  Text(
                    "สถานที่",
                    style: mystyle,
                  ),
                  Text(
                    "ท่องเที่ยว",
                    style: mystyle,
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/ambulance.svg',
                  width: 14.sp,
                  height: 17.sp,
                  color: ColorResources.KTextPink,
                ),
                onPressed: () {
                  // _toast('แจ้งเหตุฉุกเฉิน');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SosScreen()));
                },
              ),
              Text(
                "แจ้งเหตุฉุกเฉิน",
                style: mystyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
