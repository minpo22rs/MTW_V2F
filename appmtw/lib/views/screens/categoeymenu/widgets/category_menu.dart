import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/hotels/hotel_screen.dart';
import 'package:mtw_project/views/screens/pages/loading_product_screen.dart';
import 'package:mtw_project/views/screens/pages/loading_vote_screen.dart';
import 'package:mtw_project/views/screens/vote/vote_screen.dart';
import 'package:mtw_project/views/screens/vouchers/vouchers_screen.dart';
import 'package:sizer/sizer.dart';

class CategoryMenuWidget extends StatelessWidget {
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
                  'assets/icons/vote.svg',
                  width: 14.sp,
                  height: 17.sp,
                  color: ColorResources.KTextPink,
                ),
                onPressed: () {
                  // _toast('โหวตนางงาม');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoadingVoteScreen()));
                },
              ),
              Column(
                children: [
                  Text(
                    "โหวต",
                    style: mystyle,
                  ),
                  Text(
                    "นางงาม",
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
                icon: SvgPicture.asset('assets/icons/products.svg',
                    width: 14.sp,
                    height: 17.sp,
                    color: ColorResources.KTextPink),
                onPressed: () {
                  _toast('สินค้า');
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => LoadingProScreen(
                  //               pageKey: 'screen',
                  //               productKey: '',
                  //             )));
                },
              ),
              Text(
                "สินค้า",
                style: mystyle,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              IconButton(
                icon: SvgPicture.asset('assets/icons/hotel.svg',
                    width: 14.sp,
                    height: 17.sp,
                    color: ColorResources.KTextPink),
                onPressed: () {
                  // _toast('โรงแรม');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => HotelScreen(),
                    ),
                  );
                },
              ),
              Text(
                "โรงแรม",
                style: mystyle,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              IconButton(
                icon: SvgPicture.asset('assets/icons/gift-card.svg',
                    width: 14.sp,
                    height: 17.sp,
                    color: ColorResources.KTextPink),
                onPressed: () {
                  _toast('Voucher');
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => VouchersScreen(),
                  //   ),
                  // );
                },
              ),
              Text(
                "Voucher",
                style: mystyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
