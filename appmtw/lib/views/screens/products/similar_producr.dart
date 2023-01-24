import 'package:flutter/material.dart';

import 'package:mtw_project/models/similar_product_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/screens/pages/loading_product_screen.dart';
import 'package:sizer/sizer.dart';

class SimilarProduct extends StatelessWidget {
  final List similar;
  const SimilarProduct({Key? key, required this.similar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 8, top: 6),
          // color: Colors.green.withOpacity(0.2),
          height: 200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: similar.length,
              itemBuilder: (BuildContext context, int index) {
                return FlatButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoadingProScreen(
                          productKey: '${similar[index].id}',
                          pageKey: 'detail',
                        ),
                      ),
                    );
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 115.sp,
                        height: 135.sp,
                        decoration: BoxDecoration(
                          // color: Colors.redAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          border: Border.all(
                              width: 2, color: ColorResources.ICON_Light_Gray),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 115.sp,
                              height: 80.sp,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(9),
                                  topRight: Radius.circular(9),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://mtwa.xyz/storage/app/public/product/thumbnail/' +
                                          similar[index].image),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        width: 80.sp,
                                        // color: Colors.amberAccent,
                                        child: Text(
                                          similar[index].name,
                                          style: TextStyle(fontSize: 9.sp),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '฿',
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              color: ColorResources.KTextGray,
                                            ),
                                          ),
                                          Text(
                                            similar[index].price.toString(),
                                            style: TextStyle(
                                              fontSize: 9.5.sp,
                                              color: ColorResources.KTextGray,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            '฿',
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              color: ColorResources.KTextRed,
                                            ),
                                          ),
                                          Text(
                                            similar[index].saleprice.toString(),
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'ขายได้ ' + '10' + ' ชิ้น',
                                            style: TextStyle(
                                              fontSize: 6.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
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
                                                  size: 4.sp,
                                                  color: Colors.yellow[700],
                                                ),
                                                Icon(
                                                  Icons.circle_rounded,
                                                  size: 4.sp,
                                                  color: Colors.yellow[700],
                                                ),
                                                Icon(
                                                  Icons.circle_rounded,
                                                  size: 4.sp,
                                                  color: Colors.yellow[700],
                                                ),
                                                Icon(
                                                  Icons.circle_rounded,
                                                  size: 4.sp,
                                                  color: Colors.yellow[700],
                                                ),
                                                Icon(
                                                  Icons.circle_rounded,
                                                  size: 4.sp,
                                                  color: Colors.yellow[700],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
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
                );
              }),
        )
      ],
    );
  }
}
