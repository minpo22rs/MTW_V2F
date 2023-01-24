import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mtw_project/models/banner_main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

class ImageSliderWidget extends StatefulWidget {
  final List mainbanner;
  const ImageSliderWidget({Key? key, required this.mainbanner})
      : super(key: key);
  @override
  _ImageSliderWidgetState createState() => _ImageSliderWidgetState(mainbanner);
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  late List mainbanner;
  _ImageSliderWidgetState(this.mainbanner);
  // List bannermain;
  @override
  void initState() {
    super.initState();
    test();
    // getposition().whenComplete(() {
    //   setState(() {});
    // });
  }

  Future test() async {
    // print(bannermain);
    print('...............');
    print(mainbanner);
    print('...............');
  }

  // final urlImages = [
  //   'https://mtwa.xyz/storage/app/public/banner/2021-09-03-6131c5b81e1d1.png',
  //    'assets/images/Wallpaper_2.jpg',
  //   'assets/images/Wallpaper_3.jpg',
  // ];
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget buildImage(String urlImage, int index) {
      return Container(
        width: double.infinity,
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );
    }

    Widget buildIndicator() {
      return AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: mainbanner.length,
        effect: WormEffect(
            dotWidth: 6,
            dotHeight: 6,
            dotColor: Colors.black12,
            activeDotColor: Colors.grey),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider.builder(
            itemCount: mainbanner.length,
            options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 4),
                viewportFraction: 1,
                height: 200,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                }),
            itemBuilder: (context, index, realIndex) {
              final urlImage = 'https://mtwa.xyz/storage/app/public/banner/' +
                  mainbanner[index].photo;
              return buildImage(urlImage, index);
            },
          ),
          const SizedBox(
            height: 16,
          ),
          buildIndicator(),
        ],
      ),
    );
  }
}
