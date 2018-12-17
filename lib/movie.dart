import 'package:flutter/material.dart';

class Movie {
  final String id;
  final String title;
  final String posterUrl;

  Movie({
    @required this.id,
    this.title,
    this.posterUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['imdbID'],
      title: json['Title'],
      posterUrl: json['Poster'],
    );
  }

  factory Movie.empty() {
    return Movie(
      id: null,
    );
  }

  bool isValid() {
    return id != null;
  }
}
