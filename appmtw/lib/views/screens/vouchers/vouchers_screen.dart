import 'package:flutter/material.dart';
import 'package:mtw_project/models/vouchers_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/basewidget/button/custom_button.dart';
import 'package:mtw_project/views/basewidget/search_widget.dart';
import 'package:sizer/sizer.dart';

class VouchersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Vouchers',
          style: TextStyle(color: ColorResources.KTextBlack, fontSize: 16.sp),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: ColorResources.ICON_Gray,
          ),
        ),
      ),
      body: Column(
        children: [
          SearchWidget(hintText: 'hintText'),
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Text(
                  'โปรโมชั้นเพื่อคุณ',
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          Expanded(
            child: Container(
              // color: Colors.redAccent.withOpacity(0.2),
              child: ListView.builder(
                itemCount: vouchers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(radius: 34),
                                SizedBox(width: 12),
                                Column(
                                  children: [
                                    Text('data'),
                                    Text('data'),
                                    Text('data'),
                                  ],
                                ),
                              ],
                            ),
                            CustomButton(
                              onTap: () {},
                              buttonText: 'แลกเลย',
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
