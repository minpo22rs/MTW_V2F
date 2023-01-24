import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/screens/restaurant/food_detail_screen.dart';
import 'package:sizer/sizer.dart';

class FoodListView extends StatefulWidget {
  final String title;
  final List vouchers;
  const FoodListView({Key? key, required this.title, required this.vouchers})
      : super(key: key);

  @override
  _FoodListViewState createState() => _FoodListViewState(title, vouchers);
}

class _FoodListViewState extends State<FoodListView> {
  late String title;
  late List vouchers;
  _FoodListViewState(this.title, this.vouchers);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: vouchers.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 55.sp,
                          height: 55.sp,
                          // color: Colors.redAccent.withOpacity(0.2),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://mtwa.xyz/storage/app/public/vouchers/' +
                                        vouchers[index].images),
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
                            Text(
                              vouchers[index].name,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              // color: Colors.redAccent,
                              width: 160.sp,
                              child: Text(
                                vouchers[index].details,
                                style: TextStyle(
                                  fontSize: 9.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                if (vouchers[index].unit_price != 0) ...[
                                  Text(
                                    '฿',
                                    style: TextStyle(
                                      fontSize: 9.5.sp,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${vouchers[index].unit_price}',
                                    style: TextStyle(
                                      fontSize: 9.5.sp,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '฿',
                                    style: TextStyle(
                                      fontSize: 9.5.sp,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${vouchers[index].discount}',
                                    style: TextStyle(
                                      fontSize: 9.5.sp,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ] else if (vouchers[index].unit_price == 0) ...[
                                  Text(
                                    '฿',
                                    style: TextStyle(
                                      fontSize: 9.5.sp,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${vouchers[index].discount}',
                                    style: TextStyle(
                                      fontSize: 9.5.sp,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodDetailScreen(
                                title: title, v_id: '${vouchers[index].id}'),
                          ),
                        );
                        print('เพิ่ม');
                      },
                      child: SvgPicture.asset(
                        'assets/icons/plus.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
