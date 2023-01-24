import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtw_project/models/rating_one_model.dart';
import 'package:mtw_project/models/vote_model_line_2.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/screens/pages/loading_screen.dart';
import 'package:mtw_project/views/screens/pages/loading_screen2.dart';
import 'package:mtw_project/views/screens/vote/content_member.dart';
import 'package:mtw_project/views/screens/vote/item_vote_gridview_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:social_share/social_share.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/models/vote_model_line_1.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';

class SelectVoteScreen extends StatefulWidget {
  final String mem_id, check;
  const SelectVoteScreen({Key? key, required this.mem_id, required this.check})
      : super(key: key);

  @override
  _SelectVoteScreenState createState() => _SelectVoteScreenState(mem_id, check);
}

List<bool> _selections = [false, false, false, false];

class _SelectVoteScreenState extends State<SelectVoteScreen> {
  late String mem_id, check;
  late YoutubePlayerController _controller;
  _SelectVoteScreenState(this.mem_id, this.check);
  int _counter = 0;
  bool isActive = false;
  bool isVisible = false;
  bool isVisible2 = true;

  void _voteCounter() {
    setState(() {
      _counter++;
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
  var url_video;
  void checkyoutube() {
    _controller = YoutubePlayerController(
      initialVideoId: url_video,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        hideControls: true,
        loop: true,
      ),
    );
  }

  bool fullscreen = false;
  bool checkpoint = false;
  var numformat;
  var resultDataM;
  memDetail() async {
    var url = "https://mtwa.xyz/API/contestant-detail";
    var data = {
      'ref_id': '${mem_id}',
    };
    await http.post(Uri.parse(url), body: data).then((response) async {
      var result = jsonDecode(response.body);
      resultDataM = result;
    });
    return resultDataM;
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
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                final String? userId = prefs.getString('username');
                var price = 0;
                var score = 1;
                var url = "https://mtwa.xyz/API/vote-contestant-free";
                var data = {
                  'id': '${mem_id}',
                  'price': '${price}',
                  'score': '${score}',
                  'id_v': '${userId}',
                };
                await http.post(Uri.parse(url), body: data).then((value) async {
                  if (value.statusCode == 200) {
                    var result1 = jsonDecode(value.body);
                    if (result1['status'] == 'S') {
                      var url_2 = "https://mtwa.xyz/API/account-detail";
                      var data_2 = {'userid': '${userId}'};
                      await http
                          .post(Uri.parse(url_2), body: data_2)
                          .then((value) async {
                        var result2 = jsonDecode(value.body);
                        _counter = 0;
                        checkpoint = true;
                      });

                      setState(() {
                        showToast();
                        memDetail();
                      });
                    } else if (result1['status'] == 'F') {
                      setState(() {
                        Fluttertoast.showToast(
                          toastLength: Toast.LENGTH_SHORT,
                          msg: "การ Vote เกิดปัญหากรุณาติดต่อผู้ดูแล",
                          gravity: ToastGravity.TOP,
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
                          gravity: ToastGravity.TOP,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0,
                          timeInSecForIosWeb: 3,
                        );
                      });
                    } else if (result1['status'] == 'E') {
                      setState(() {
                        Fluttertoast.showToast(
                          toastLength: Toast.LENGTH_SHORT,
                          msg:
                              "คุณได้ใช้สิทธิโหวตฟรีของวันนี้ไปเรียบร้อยแล้วค่ะ",
                          gravity: ToastGravity.TOP,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0,
                          timeInSecForIosWeb: 3,
                        );
                      });
                    }
                  }
                  setState(() {
                    Navigator.pop(context);
                  });
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
  void initState() {
    super.initState();
    memDetail();
  }

  @override
  Widget build(BuildContext context) {
    int endTime = DateTime.now().millisecondsSinceEpoch + 864000 * 100;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () async {
              setState(() {
                Navigator.pop(context);
              });
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: ColorResources.ICON_Gray,
            )),
        title: Text(
          'VOTE',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
        future: memDetail(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          url_video = resultDataM['link_video'];
          checkyoutube();

          return ListView(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  if (resultDataM['region'] == 'C') ...[
                    Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.amber,
                      child: Image.asset(
                        Images.central,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ] else if (resultDataM['region'] == 'NE') ...[
                    Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.amber,
                      child: Image.asset(
                        Images.northeasternregion,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ] else if (resultDataM['region'] == 'B') ...[
                    Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.amber,
                      child: Image.asset(
                        Images.bangkok,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ] else if (resultDataM['region'] == 'N') ...[
                    Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.amber,
                      child: Image.asset(
                        Images.north,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ] else if (resultDataM['region'] == 'S') ...[
                    Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.amber,
                      child: Image.asset(
                        Images.south,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ] else if (resultDataM['region'] == 'E') ...[
                    Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.amber,
                      child: Image.asset(
                        Images.easternregion,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                  Positioned(
                    bottom: -50,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundImage: NetworkImage(
                                'https://mtwa.xyz/storage/app/public/user/' +
                                    '${resultDataM['image']}'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 7, top: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     showModalBottomSheet(
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(15),
                    //         ),
                    //         context: context,
                    //         builder: (context) {
                    //           return Container(
                    //             // width: double.infinity,
                    //             height: 280,
                    //             // decoration: BoxDecoration(
                    //             //   borderRadius: (BorderRadius.only(
                    //             //     topLeft: Radius.circular(40),
                    //             //     topRight: Radius.circular(12),
                    //             //   )),
                    //             // ),
                    //             // color: Colors.redAccent.withOpacity(0.2),
                    //             child: Column(
                    //               children: [
                    //                 SizedBox(
                    //                   height: 15,
                    //                 ),
                    //                 Text(
                    //                   'แบ่งปันข้อมูล',
                    //                   style: TextStyle(
                    //                     fontSize: 12.sp,
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 20,
                    //                 ),
                    //                 Container(
                    //                   width: double.infinity,
                    //                   height: 90,
                    //                   // color: Colors.redAccent,
                    //                   child: Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceAround,
                    //                     children: [
                    //                       Column(
                    //                         children: [
                    //                           GestureDetector(
                    //                             onTap: () {
                    //                             },
                    //                             child: Container(
                    //                               width: 50,
                    //                               height: 50,
                    //                               decoration: BoxDecoration(
                    //                                 image: DecorationImage(
                    //                                   image: AssetImage(
                    //                                     share_line,
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ),
                    //                           SizedBox(
                    //                             height: 4,
                    //                           ),
                    //                           Text(
                    //                             'Line',
                    //                             style: TextStyle(
                    //                               fontWeight: FontWeight.bold,
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                       Column(
                    //                         children: [
                    //                           GestureDetector(
                    //                             onTap: () {
                    //                               SocialShare.shareInstagramStory(
                    //                                   Images.central);
                    //                             },
                    //                             child: Container(
                    //                               width: 50,
                    //                               height: 50,
                    //                               decoration: BoxDecoration(
                    //                                 image: DecorationImage(
                    //                                   image: AssetImage(
                    //                                     share_ig,
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ),
                    //                           SizedBox(
                    //                             height: 4,
                    //                           ),
                    //                           Text(
                    //                             'Instagram',
                    //                             style: TextStyle(
                    //                               fontWeight: FontWeight.bold,
                    //                             ),
                    //                           ),
                    //                           Text(
                    //                             'Stories',
                    //                             style: TextStyle(
                    //                               fontWeight: FontWeight.bold,
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                       Column(
                    //                         children: [
                    //                           GestureDetector(
                    //                             onTap: () {
                    //                             },
                    //                             child: SvgPicture.asset(
                    //                               'assets/icons/share_link.svg',
                    //                               width: 50,
                    //                               height: 50,
                    //                             ),
                    //                           ),
                    //                           SizedBox(
                    //                             height: 4,
                    //                           ),
                    //                           Text(
                    //                             'Copy link',
                    //                             style: TextStyle(
                    //                               fontWeight: FontWeight.bold,
                    //                             ),
                    //                           )
                    //                         ],
                    //                       ),
                    //                       Column(
                    //                         children: [
                    //                           GestureDetector(
                    //                             onTap: () {
                    //                             },
                    //                             child: Container(
                    //                               width: 50,
                    //                               height: 50,
                    //                               decoration: BoxDecoration(
                    //                                 image: DecorationImage(
                    //                                   image: AssetImage(
                    //                                     share_messenger,
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ),
                    //                           SizedBox(
                    //                             height: 4,
                    //                           ),
                    //                           Text(
                    //                             'Messenger',
                    //                             style: TextStyle(
                    //                               fontWeight: FontWeight.bold,
                    //                             ),
                    //                           )
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 10,
                    //                 ),
                    //                 ElevatedButton(
                    //                   onPressed: () {
                    //                     Navigator.pop(context);
                    //                   },
                    //                   child: Text(
                    //                     'ยกเลิก',
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           );
                    //         });
                    //   },
                    //   child: Icon(
                    //     Icons.ios_share,
                    //     size: 24.sp,
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  Text(
                    '${resultDataM['f_name']} ${resultDataM['l_name']}',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '${resultDataM['name_th']}',
                    style: TextStyle(fontSize: 9.sp),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "คะแนนโหวต " + '${resultDataM['rating']}' + " คะแนน",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: Column(
                      children: [
                        if (checkpoint == false) ...[
                          if (check == '0') ...[
                            ElevatedButton(
                              child: Text('โหวตฟรี'),
                              onPressed: () {
                                _showMyDialog();
                              },
                            ),
                          ]
                        ]
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isVisible2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan[800],
                      ),
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                          isVisible2 = !isVisible2;
                        });
                      },
                      child: Text(
                        'โหวต',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Column(
                      children: [
                        Divider(
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 60),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                'VOTE',
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 60,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                      isVisible2 = !isVisible2;
                                    });
                                  },
                                  child: Icon(Icons.close),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ItemVoteScreen(
                          vote_id: mem_id,
                          check: check,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ประวัตินางงาม',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // child: AspectRatio(
                        //   aspectRatio: 16 / 9,
                        //   child: BetterPlayer.network(
                        //     'https://www.youtube.com/watch?v=kTJczUoc26U&ab_channel=TheKidLAROIVEVO',
                        //     betterPlayerConfiguration: BetterPlayerConfiguration(
                        //       aspectRatio: 16 / 9,
                        //     ),
                        //   ),
                        // ),
                        child: YoutubePlayerBuilder(
                          onEnterFullScreen: () {
                            this.fullscreen = true;
                          },
                          onExitFullScreen: () {
                            this.fullscreen = false;
                          },
                          player: YoutubePlayer(
                            aspectRatio: 16 / 9,
                            showVideoProgressIndicator: true,
                            controller: _controller,
                          ),
                          builder: (context, player) {
                            return Column(
                              children: [
                                player,
                              ],
                            );
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'คำอธิบายโดยย่อของนางงาม',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(resultDataM['detail'].toString()),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'วัน/เดือน/ปีเกิด',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(resultDataM['birth'].toString()),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'ส่วนสูง (เซนติเมตร)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(resultDataM['height'].toString()),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'น้ำหนัก (กิโลกรัม)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(resultDataM['weight'].toString()),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'สัดส่วน (รอบอก / รอบเอว / รอบสะโพก)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(resultDataM['proportion'].toString()),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'ความสามารถพิเศษ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(resultDataM['skill'].toString()),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'ประวิติการศึกษา',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(resultDataM['educate'].toString()),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'เหตุผลที่เลือกจังหวัด' + resultDataM['name_th'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(resultDataM['interest'].toString()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    ContentMem(
                      mId: '${resultDataM['id']}',
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Widget _buildVoteSucess() {
//   return Dialog(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(16.0),
//     ),
//     backgroundColor: Colors.white,
//     child: Container(
//       height: 90.sp,
//       child: Column(
//         children: [
//           Stack(
//             alignment: Alignment.centerRight,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Column(
//                     children: [
//                       Icon(
//                         Icons.circle,
//                         size: 55.sp,
//                       ),
//                       Text(
//                         'โหวตนางงามเรียบร้อย',
//                         style: TextStyle(
//                           fontSize: 17.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Widget _buildItemVote() {
//   return Column(
//     children: [
//       IconButton(
//         onPressed: () {
//           _voteCounter();
//         },
//         icon: Icon(Icons.circle),
//       ),
//       Text(
//         'หัวใจ',
//         style: TextStyle(
//           fontSize: 9.sp,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       Text(
//         '3 คะแนน',
//         style: TextStyle(
//           fontSize: 7.sp,
//         ),
//       ),
//       Text(
//         '฿30.00',
//         style: TextStyle(
//           fontSize: 7.sp,
//         ),
//       ),
//     ],
//   );
// }

// Widget _buildDialog() {
//   return Dialog(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(16.0),
//     ),
//     // elevation: 0.0,
//     backgroundColor: Colors.white,
//     child: Container(
//       height: 225.sp,
//       child: Column(
//         children: [
//           Stack(
//             alignment: Alignment.centerRight,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     'VOTE',
//                     style: TextStyle(
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )
//                 ],
//               ),
//               IconButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(false);
//                 },
//                 icon: Icon(Icons.close),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildItemVote(),
//               _buildItemVote(),
//               _buildItemVote(),
//               _buildItemVote(),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildItemVote(),
//               _buildItemVote(),
//               _buildItemVote(),
//               _buildItemVote(),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   return _buildVoteSucess();
//                 },
//               );
//             },
//             child: const Text('โหวต'),
//           ),
//         ],
//       ),
//     ),
//   );
// }
