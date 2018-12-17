import 'package:flutter/material.dart';
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
  TextEditingController _controller;

  @override
  void initState() {
    _future = service.getMovieDetail(widget.movieTitle);
    _controller = TextEditingController(text: widget.movieTitle);
    super.initState();
  }

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
      controller: _controller,
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
        hintText: "Type a movie title",
      ),
    );
  }

  Widget _buildContent() {
    return Flexible(
      child: Center(
        child: FutureBuilder<dynamic>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();

            if (snapshot.hasData && snapshot.data != null) {
              Movie movie = snapshot.data as Movie;
              return MoviePoster(movie: movie);
            } else if (snapshot.hasData && snapshot.data is String) {
              return Text("${snapshot.data}");
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
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
    return Image.network(
      movie.posterUrl,
      fit: BoxFit.contain,
    );
  }
}
