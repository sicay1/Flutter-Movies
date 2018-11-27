import 'package:flutter/material.dart';

class ImageHero extends StatelessWidget {
  final String tag;
  final String imageUrl;
  final double width;
  final double height;

  const ImageHero({this.tag, this.imageUrl, this.width, this.height});

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Hero(
        tag: tag + "_ImageHero",
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
