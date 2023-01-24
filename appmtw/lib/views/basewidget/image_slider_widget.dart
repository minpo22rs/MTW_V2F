import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSlider extends StatefulWidget {
  final String pageKey;
  final List image;
  const ImageSlider({Key? key, required this.pageKey, required this.image})
      : super(key: key);
  @override
  _ImageSliderState createState() => _ImageSliderState(pageKey, image);
}

class _ImageSliderState extends State<ImageSlider> {
  late String pageKey;
  late List image;
  _ImageSliderState(this.pageKey, this.image);
  // final List<String> urlImages = [
  //   // '',
  //   Images.bangkok,
  //   Images.central,
  //   Images.easternregion,
  //   Images.north,
  //   Images.northeasternregion,
  //   Images.south,
  // ];
  @override
  void initState() {
    super.initState();
    checkKey();
  }

  var url;
  void checkKey() {
    if (pageKey == "product") {
      url = "https://mtwa.xyz/storage/app/public/product/";
    } else if (pageKey == "attraction") {
      url = "https://mtwa.xyz/storage/app/public/location/";
    } else if (pageKey == "restaurant") {
      url = "https://mtwa.xyz/storage/app/public/seller/";
    } else if (pageKey == "hotels") {
      url = "https://mtwa.xyz/storage/app/public/seller/";
    } else if (pageKey == "rooms") {
      url = "https://mtwa.xyz/storage/app/public/hotel/";
    } else if (pageKey == "food") {
      url = "https://mtwa.xyz/storage/app/public/restaurant/";
    }
  }

  int activeIndex = 0;

  Widget buildImage(String urlImages, int index) {
    return Container(
      width: double.infinity,
      // margin: EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey,
      child: Image.network(
        urlImages,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: image.length,
      effect: WormEffect(
        dotWidth: 6,
        dotHeight: 6,
        dotColor: Colors.black12,
        activeDotColor: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: image.length,
            options: CarouselOptions(
                viewportFraction: 1,
                height: 250,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                }),
            itemBuilder: (context, index, realIndex) {
              final urlImage = url + image[index].img;
              return buildImage(urlImage, index);
            },
          ),
          SizedBox(
            height: 14,
          ),
          buildIndicator(),
        ],
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
