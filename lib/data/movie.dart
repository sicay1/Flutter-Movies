import 'package:flutter/material.dart';

class Movie {
  final String id;
  final String title;
  final String year;
  final String posterUrl;

  Movie(
      {@required this.id,
      @required this.title,
      @required this.year,
      @required this.posterUrl});
}
