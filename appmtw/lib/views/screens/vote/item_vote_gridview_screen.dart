import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mtw_project/models/item_vote_model.dart';
import 'package:mtw_project/models/rating_one_model.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:mtw_project/views/screens/vote/select_vote_screen.dart';
import 'package:intl/intl.dart';

class ItemVoteScreen extends StatefulWidget {
  final String vote_id, check;
  const ItemVoteScreen({
    Key? key,
    required this.vote_id,
    required this.check,
  }) : super(key: key);

  @override
  _ItemVoteScreenState createState() => _ItemVoteScreenState(vote_id, check);
}

class _ItemVoteScreenState extends State<ItemVoteScreen> {
  late String vote_id, check, pageKey;
  _ItemVoteScreenState(
    this.vote_id,
    this.check,
  );
  int _counter = 0;
  int scoreshow = 0;
  int priceitem = 0;
  int scoreitem = 0;
  late List<int> voteitemscore = [];
  late List<int> voteitemprice = [];
  bool _isButtonDisabled = true;

  void _voteCounter(scoreitem, priceitem) {
    setState(() {
      voteitemscore.add(scoreitem);
      voteitemprice.add(priceitem);
      scoreshow = voteitemscore.reduce((a, b) => a + b);
      _counter++;
      _isButtonDisabled = false;
    });
  }

  void showToast() => Fluttertoast.showToast(
        toastLength: Toast.LENGTH_SHORT,
        msg: "โหวตนางงามเรียบร้อย",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
        timeInSecForIosWeb: 3,
      );

  void vote_con() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    var price = voteitemprice.reduce((a, b) => a + b);
    var score = voteitemscore.reduce((a, b) => a + b);
    var url = "https://mtwa.xyz/API/vote-contestant";
    var data = {
      'id': '${vote_id}',
      'price': '${price}',
      'score': '${score}',
      'id_v': '${userId}',
    };
    await http.post(Uri.parse(url), body: data).then((response) async {
      var result1 = jsonDecode(response.body);
      if (result1['status'] == 'S') {
        setState(() {
          _isButtonDisabled = true;
          voteitemscore = [];
          voteitemprice = [];
          scoreshow = 0;
          _counter = 0;
          showToast();
        });
      } else if (result1['status'] == 'F') {
        setState(() {
          Fluttertoast.showToast(
            toastLength: Toast.LENGTH_SHORT,
            msg: "การ Vote เกิดปัญหากรุณาติดต่อผู้ดูแล",
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0,
            timeInSecForIosWeb: 3,
          );
        });
      } else if (result1['status'] == 'C') {
        setState(() {
          Fluttertoast.showToast(
            toastLength: Toast.LENGTH_SHORT,
            msg: "ยอดเงินใน wallet ของคุณไม่เพียงพอ",
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0,
            timeInSecForIosWeb: 3,
          );
        });
      }
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการโหวต'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('ยกเลิก')),
            ElevatedButton(
              onPressed: () async {
                vote_con();
                setState(() {
                  Navigator.pop(context);
                });
              },
              child: Text('ยืนยัน'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 255,
          // color: Colors.redAccent.withOpacity(0.2),
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: itemvotes.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      _voteCounter(
                          itemvotes[index].score, itemvotes[index].price);
                    },
                    child: Tab(
                      icon: Image.asset(itemvotes[index].image),
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    itemvotes[index].name,
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${itemvotes[index].score}' + ' คะแนน',
                    style: TextStyle(
                      fontSize: 7.sp,
                    ),
                  ),
                  Text(
                    '฿ ' + '${itemvotes[index].price}' + '.00',
                    style: TextStyle(
                      fontSize: 7.sp,
                      color: Colors.cyan[700],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _isButtonDisabled ? null : _showMyDialog();
                  },
                  child: Text(
                    'โหวต ' + '($scoreshow)',
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        _isButtonDisabled ? Colors.black : Colors.blueAccent),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 40,
              bottom: 6,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isButtonDisabled = true;
                    voteitemscore = [];
                    voteitemprice = [];
                    scoreshow = 0;
                    _counter = 0;
                  });
                },
                child: Text(
                  'รีเซ็ต',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
