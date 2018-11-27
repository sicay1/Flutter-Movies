import 'package:flutter/material.dart';
import '../data/movie.dart';
import '../widgets/image_hero.dart';
import '../widgets/text_hero.dart';

class DetailPage extends StatelessWidget {
  final Movie movie;

  DetailPage({this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Detail"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageHero(
              tag: movie.id,
              imageUrl: movie.posterUrl,
              height: 300,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 32,
              ),
              child: TextHero(
                tag: movie.id,
                text: movie.title,
                isCenter: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
