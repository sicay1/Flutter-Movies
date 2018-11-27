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

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['imdbID'],
        title: json['Title'],
        year: json['Year'],
        posterUrl: json['Poster']);
  }
}
