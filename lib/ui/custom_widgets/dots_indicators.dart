import 'package:flutter/material.dart';

class DotsIndicators extends StatelessWidget {
  final int? index;
  final int? currentImage;
  final double height;
  final double width;
  final int? pageIndex;
  final Color selectedColor;
  final Color unSelectedColor;

  DotsIndicators(
      {this.index,
      this.currentImage,
      this.height = 15,
      this.width = 15,
      this.pageIndex,
      this.selectedColor = Colors.white,
      this.unSelectedColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: index == currentImage ? selectedColor : unSelectedColor),
    );
  }
}
