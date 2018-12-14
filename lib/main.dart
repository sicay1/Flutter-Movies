import 'package:flutter/material.dart';
import 'movie_service.dart' as service;
import 'movie.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movie App",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MoviePage(movieTitle: "inception"),
    );
  }
}

class MoviePage extends StatefulWidget {
  final String movieTitle;

  MoviePage({this.movieTitle});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  Future _future;

  @override
  void initState() {
    _future = service.getMovieDetail(widget.movieTitle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Movie App"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            _buildButtonBar(),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonBar() {
    return Row(
      children: <Widget>[
        Spacer(),
        RaisedButton(
          child: Text("Inception"),
          onPressed: () => setState(() {
                _future = service.getMovieDetail("inception");
              }),
        ),
        Spacer(),
        RaisedButton(
          child: Text("Lion King"),
          onPressed: () => setState(() {
                _future = service.getMovieDetail("lion king");
              }),
        ),
        Spacer(),
      ],
    );
  }

  Widget _buildContent() {
    return Flexible(
      child: FutureBuilder<dynamic>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          if (snapshot.hasData && snapshot.data is Movie) {
            Movie movie = snapshot.data as Movie;
            return MovieInfo(movie: movie);
          } else if (snapshot.hasData && snapshot.data is String) {
            return Text("${snapshot.data}");
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
        },
      ),
    );
  }
}

class MovieInfo extends StatelessWidget {
  final Movie movie;

  MovieInfo({this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.network(
          movie.posterUrl,
          height: 300,
          fit: BoxFit.contain,
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            movie.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
