import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/movie.dart';

const String _API_KEY = "583ac0ed";

Future<dynamic> searchMovies(String searchKey) async {
  if (searchKey.isEmpty) {
    return "Type to search!";
  }

  final http.Response response = await http.get(
      "http://www.omdbapi.com/" + "?s=" + searchKey + "&apikey=" + _API_KEY);

  print(response.body);

  Map responseJson = json.decode(response.body.toString());
  if (responseJson["Response"] == "False") {
    String errMessage = responseJson["Error"];
    return errMessage;
  } else {
    List<Movie> movieList = _parseSearchResults(responseJson["Search"]);
    return movieList;
  }
}

List<Movie> _parseSearchResults(List data) {
  List<Movie> list = List();

  for (int i = 0; i < data.length; i++) {
    String id = data[i]["imdbID"];
    String title = data[i]["Title"];
    String year = data[i]["Year"];
    String posterUrl = data[i]["Poster"];

    list.add(Movie(
      id: id,
      title: title,
      year: year,
      posterUrl: posterUrl,
    ));
  }

  return list;
}
