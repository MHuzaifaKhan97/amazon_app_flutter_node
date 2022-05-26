import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/constants/global_variables.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 1,
          height: 200,
        ),
        items: GlobalVariables.carouselImages.map((i) {
          return Builder(builder: (context) {
            return Image.network(
              i,
              fit: BoxFit.cover,
              height: 300,
            );
          });
        }).toList());
  }
}
