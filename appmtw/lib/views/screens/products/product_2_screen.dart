import 'package:flutter/material.dart';
import 'package:mtw_project/views/basewidget/search_widget.dart';
import 'package:mtw_project/views/screens/products/product_gridview.dart';
import 'package:sizer/sizer.dart';

class ProductScreen2 extends StatelessWidget {
  final List products;
  final String title;
  const ProductScreen2({Key? key, required this.products, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title != '' ? title : 'สินค้า'),
      ),
      body: Column(
        children: [
          SearchWidget(
            hintText: '',
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'เกี่ยวข้อง',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                'ล่าสุด',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                'สินค้าขายดี',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                'ราคา',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          ProductGridView(products: products),
          // Container(
          //   width: double.infinity,
          //   height: 500.sp,
          //   child:
          // ),
        ],
      ),
    );
  }
}
