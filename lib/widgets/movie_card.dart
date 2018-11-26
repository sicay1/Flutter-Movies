import 'package:flutter/material.dart';
import '../data/movie.dart';
import '../pages/detail_page.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailPage()),
          ),
      child: Card(
        margin: EdgeInsets.only(bottom: 8),
        child: Row(
          children: <Widget>[
            Image.network(
              movie.posterUrl,
              height: 120,
              width: 80,
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      movie.title,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
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
