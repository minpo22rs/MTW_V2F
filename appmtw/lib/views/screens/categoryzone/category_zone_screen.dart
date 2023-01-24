import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mtw_project/models/member_model.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/screens/categoryzone/widgets/category_zone_widget.dart';
import 'package:mtw_project/views/screens/vote/vote_central_screen.dart';
import 'package:http/http.dart' as http;

class CategoryZoneScreen extends StatefulWidget {
  final String wallet, pageKey;
  const CategoryZoneScreen(
      {Key? key, required this.wallet, required this.pageKey})
      : super(key: key);
  @override
  _CategoryZoneScreenState createState() =>
      _CategoryZoneScreenState(wallet, pageKey);
}

class _CategoryZoneScreenState extends State<CategoryZoneScreen> {
  late String resultname;
  late String wallet, pageKey;
  _CategoryZoneScreenState(this.wallet, this.pageKey);

  List<Member> mem = <Member>[];
  var resultMem;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.redAccent.withOpacity(0.2),
      height: 280,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryZoneWidget(
                  onPressed: () async {
                    var url = "https://mtwa.xyz/API/regions-name";
                    var nameregion;
                    var data = {
                      'keyword': 'C',
                    };
                    await http.post(Uri.parse(url), body: data).then((respone) {
                      print('this response = ${respone.body}');
                      var region = jsonDecode(respone.body);
                      print(region['name']);
                      nameregion = region['name'];
                      // print(resultname);
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VoteCentralScreen(
                                  region2: 'C',
                                  region: '${nameregion}',
                                  wallet: wallet,
                                  pageKey: '${pageKey}',
                                )));
                  },
                  nameProvince: 'ภาคกลาง',
                  image: AssetImage(Images.central),
                ),
                CategoryZoneWidget(
                  onPressed: () async {
                    var url = "https://mtwa.xyz/API/regions-name";
                    var nameregion;
                    var data = {
                      'keyword': 'NE',
                    };
                    await http.post(Uri.parse(url), body: data).then((respone) {
                      print('this response = ${respone.body}');
                      var region = jsonDecode(respone.body);
                      print(region['name']);
                      nameregion = region['name'];
                      // print(resultname);
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VoteCentralScreen(
                                  region2: 'NE',
                                  region: '${nameregion}',
                                  wallet: wallet,
                                  pageKey: '${pageKey}',
                                )));
                  },
                  nameProvince: 'ภาคอีสาน',
                  image: AssetImage(Images.northeasternregion),
                ),
                CategoryZoneWidget(
                  onPressed: () async {
                    var url = "https://mtwa.xyz/API/regions-name";
                    var nameregion;
                    var data = {
                      'keyword': 'B',
                    };
                    await http.post(Uri.parse(url), body: data).then((respone) {
                      print('this response = ${respone.body}');
                      var region = jsonDecode(respone.body);
                      print(region['name']);
                      nameregion = region['name'];
                      // print(resultname);
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VoteCentralScreen(
                                  region2: 'B',
                                  region: '${nameregion}',
                                  wallet: wallet,
                                  pageKey: '${pageKey}',
                                )));
                  },
                  nameProvince: 'กรุงเทพมหานคร',
                  image: AssetImage(Images.bangkok),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryZoneWidget(
                  onPressed: () async {
                    var url = "https://mtwa.xyz/API/regions-name";
                    var nameregion;
                    var data = {
                      'keyword': 'N',
                    };
                    await http.post(Uri.parse(url), body: data).then((respone) {
                      print('this response = ${respone.body}');
                      var region = jsonDecode(respone.body);
                      print(region['name']);
                      nameregion = region['name'];
                      // print(resultname);
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VoteCentralScreen(
                                  region2: 'N',
                                  region: '${nameregion}',
                                  wallet: wallet,
                                  pageKey: '${pageKey}',
                                )));
                  },
                  nameProvince: 'ภาคเหนือ',
                  image: AssetImage(Images.north),
                ),
                CategoryZoneWidget(
                  onPressed: () async {
                    var url = "https://mtwa.xyz/API/regions-name";
                    var nameregion;
                    var data = {
                      'keyword': 'S',
                    };
                    await http.post(Uri.parse(url), body: data).then((respone) {
                      print('this response = ${respone.body}');
                      var region = jsonDecode(respone.body);
                      print(region['name']);
                      nameregion = region['name'];
                      // print(resultname);
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VoteCentralScreen(
                                  region2: 'S',
                                  region: '${nameregion}',
                                  wallet: wallet,
                                  pageKey: '${pageKey}',
                                )));
                  },
                  nameProvince: 'ภาคใต้',
                  image: AssetImage(Images.south),
                ),
                CategoryZoneWidget(
                  onPressed: () async {
                    var url = "https://mtwa.xyz/API/regions-name";
                    var nameregion;
                    var data = {
                      'keyword': 'E',
                    };
                    await http.post(Uri.parse(url), body: data).then((respone) {
                      print('this response = ${respone.body}');
                      var region = jsonDecode(respone.body);
                      print(region['name']);
                      nameregion = region['name'];
                      // print(resultname);
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VoteCentralScreen(
                                  region2: 'E',
                                  region: '${nameregion}',
                                  wallet: wallet,
                                  pageKey: '${pageKey}',
                                )));
                  },
                  nameProvince: 'ภาคตะวันออก',
                  image: AssetImage(Images.easternregion),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
