import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mtw_project/models/category_product_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/basewidget/search_widget.dart';
import 'package:mtw_project/views/screens/pages/loading_product_screen.dart';
import 'package:mtw_project/views/screens/products/product_2_screen.dart';
import 'package:mtw_project/views/screens/products/recommended_product_screen.dart';
import 'package:sizer/sizer.dart';

class ProductScreen extends StatefulWidget {
  final List categoryProduct, products;
  final String bannersub, bannerfooter;
  const ProductScreen(
      {Key? key,
      required this.categoryProduct,
      required this.products,
      required this.bannersub,
      required this.bannerfooter})
      : super(key: key);

  @override
  _ProductScreenState createState() =>
      _ProductScreenState(categoryProduct, products, bannersub, bannerfooter);
}

class _ProductScreenState extends State<ProductScreen> {
  late List categoryProduct, products;
  late String bannersub, bannerfooter;
  _ProductScreenState(
      this.categoryProduct, this.products, this.bannersub, this.bannerfooter);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: ColorResources.ICON_Gray,
          ),
        ),
        title: Text(
          'สินค้า',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SearchWidget(
                hintText: 'ค้นหา สินค้า ที่คุณต้องการ',
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
                width: double.infinity,
                height: 100.sp,
                color: Colors.amberAccent,
                child: Image.network(
                  'https://mtwa.xyz/storage/app/public/banner/' + bannersub,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                margin: EdgeInsets.only(left: 0, right: 0),
                width: double.infinity,
                height: 175.sp,
                // color: Colors.redAccent.withOpacity(0.2),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 5,
                    crossAxisCount: 4,
                  ),
                  itemCount: categoryProduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoadingProScreen(
                                              pageKey:
                                                  '${categoryProduct[index].namecatrory}',
                                              productKey:
                                                  '${categoryProduct[index].id}',
                                            )));
                              },
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                  'https://mtwa.xyz/storage/app/public/category/' +
                                      categoryProduct[index].image,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 70,
                              height: 35,
                              // color: Colors.amber,
                              child: Text(
                                categoryProduct[index].namecatrory,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                                maxLines: 3,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
                width: double.infinity,
                height: 100.sp,
                color: Colors.amberAccent,
                child: Image.network(
                  'https://mtwa.xyz/storage/app/public/banner/' + bannerfooter,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 26, right: 26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'สินค้าแนะนำ',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoadingProScreen(
                                  pageKey: 'all',
                                  productKey: '',
                                )));
                  },
                  child: Text(
                    'ดูทั้งหมด',
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: ColorResources.KTextLightBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          RecommendedProductScreen(products: products),
        ],
      ),
    );
  }
}
