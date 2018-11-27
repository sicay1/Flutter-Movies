import 'package:flutter/material.dart';
import '../data/movie.dart';
import 'image_hero.dart';
import 'text_hero.dart';
import '../pages/detail_page.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailPage(movie: movie)),
          ),
      child: Card(
        margin: EdgeInsets.only(bottom: 8),
        child: Row(
          children: <Widget>[
            ImageHero(
              tag: movie.id,
              imageUrl: movie.posterUrl,
              height: 120,
              width: 80,
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextHero(
                      tag: movie.id,
                      text: movie.title,
                    ),
                    Text(movie.year),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
