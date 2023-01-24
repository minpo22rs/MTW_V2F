import 'package:flutter/material.dart';

class SelectPayment extends StatelessWidget {
  const SelectPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'ช่องทางการชำระเงิน',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('บัตรเครดิต/บัตรเดบิต'),
                    Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: 30,
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              )
            ],
          ),
        ],
      ),
    );
  }
}
