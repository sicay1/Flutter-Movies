import 'package:flutter/material.dart';
import 'dart:io';
import 'movie_service.dart' as service;
import 'movie.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: "Movie App",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MoviePage(),
    );
  }
}

class MoviePage extends StatefulWidget {
  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  Future<Movie> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Movie App"),
      ),
      body: Column(
        children: <Widget>[
          _buildSearchBar(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      textInputAction: TextInputAction.search,
      onSubmitted: (input) {
        setState(() {
          _future = service.getMovieDetail(input);
        });
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Theme.of(context).primaryColor,
        ),
        hintText: "Movie title (e.g. inception)",
      ),
    );
  }

  Widget _buildContent() {
    return Flexible(
      child: Center(
        child: FutureBuilder<Movie>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none)
              return Text("Search for a movie to see its poster!");
            if (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();

            if (snapshot.hasData && snapshot.data.isValid()) {
              return MoviePoster(movie: snapshot.data);
            } else {
              return Text(
                "Error!",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  final Movie movie;

  MoviePoster({this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Platform.isAndroid ? Colors.cyan : Colors.amber,
      child: Image.network(
        movie.posterUrl,
        fit: BoxFit.contain,
      ),
    );
  }
}
