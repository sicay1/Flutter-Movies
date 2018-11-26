import 'package:flutter/material.dart';
import '../data/movie.dart';
import '../data/movie_service.dart' as service;
import '../widgets/movie_card.dart';

class SearchPage extends StatefulWidget {
  final String title;

  SearchPage({this.title});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchKey = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          _buildSearchBar(),
          _buildMovieList(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (input) {
          FocusScope.of(context).requestFocus(new FocusNode());
          setState(() {
            searchKey = input;
          });
        },
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
          hintText: "Search movie",
        ),
      ),
    );
  }

  Widget _buildMovieList() {
    return Flexible(
      child: Center(
        child: Container(
          child: FutureBuilder<dynamic>(
            future: service.searchMovies(searchKey),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();

              if (snapshot.hasData && snapshot.data is List<Movie>) {
                return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) =>
                      MovieCard(snapshot.data[index]),
                );
              } else if (snapshot.hasData && snapshot.data is String) {
                return Text("${snapshot.data}");
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
            },
          ),
        ),
      ),
    );
  }
}
