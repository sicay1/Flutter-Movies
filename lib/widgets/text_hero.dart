import 'package:flutter/material.dart';

class TextHero extends StatelessWidget {
  final String tag;
  final String text;
  final bool isCenter;

  const TextHero({this.tag, this.text, this.isCenter = false});

  Widget build(BuildContext context) {
    return Hero(
      tag: tag + "_TextHero",
      child: Material(
        color: Colors.transparent,
        child: Text(
          text,
          softWrap: true,
          maxLines: 2,
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
