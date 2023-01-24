import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class StarWidget extends StatefulWidget {
  final String sizestar, sId, type;
  StarWidget(
      {Key? key, required this.sizestar, required this.sId, required this.type})
      : super(key: key);
  @override
  _StarWidgetState createState() => _StarWidgetState(sizestar, sId, type);
}

class _StarWidgetState extends State<StarWidget> {
  late String sizestar, sId, type;
  _StarWidgetState(this.sizestar, this.sId, this.type);
  var rating;
  ratingstar() async {
    var link = "https://mtwa.xyz/API/stardust";
    var data = {
      'sId': sId,
      'type': type,
    };
    await http.post(Uri.parse(link), body: data).then((value) {
      var result = jsonDecode(value.body);
      rating = result;
    });
    return rating;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ratingstar(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (double.parse('${rating}') < 0.51) ...[
              for (int i = 0; i < 5; i++) ...[
                Icon(
                  Icons.star,
                  size: int.parse(sizestar).sp,
                  color: Colors.black26,
                ),
              ]
            ] else if (double.parse('${rating}') < 1.51) ...[
              for (int i = 0; i < 1; i++) ...[
                Icon(
                  Icons.star,
                  size: int.parse(sizestar).sp,
                  color: Colors.yellow[700],
                ),
              ],
              for (int i = 0; i < 4; i++) ...[
                Icon(
                  Icons.star,
                  size: int.parse(sizestar).sp,
                  color: Colors.black26,
                ),
              ]
            ] else if (double.parse('${rating}') < 2.51) ...[
              for (int i = 0; i < 2; i++) ...[
                Icon(
                  Icons.star,
                  size: int.parse(sizestar).sp,
                  color: Colors.yellow[700],
                ),
              ],
              for (int i = 0; i < 3; i++) ...[
                Icon(
                  Icons.star,
                  size: int.parse(sizestar).sp,
                  color: Colors.black26,
                ),
              ]
            ] else if (double.parse('${rating}') < 3.51) ...[
              for (int i = 0; i < 3; i++) ...[
                Icon(
                  Icons.star,
                  size: int.parse(sizestar).sp,
                  color: Colors.yellow[700],
                ),
              ],
              for (int i = 0; i < 2; i++) ...[
                Icon(
                  Icons.star,
                  size: int.parse(sizestar).sp,
                  color: Colors.black26,
                ),
              ]
            ] else if (double.parse('${rating}') <= 4.51) ...[
              for (int i = 0; i < 4; i++) ...[
                Icon(
                  Icons.star,
                  size: int.parse(sizestar).sp,
                  color: Colors.yellow[700],
                ),
              ],
              for (int i = 0; i < 1; i++) ...[
                Icon(
                  Icons.star,
                  size: int.parse(sizestar).sp,
                  color: Colors.black26,
                ),
              ]
            ] else if (double.parse('${rating}') > 4.50) ...[
              for (int i = 0; i < 5; i++) ...[
                Icon(
                  Icons.star,
                  size: int.parse(sizestar).sp,
                  color: Colors.yellow[700],
                ),
              ]
            ]
          ],
        );
      },
    );
  }
}
