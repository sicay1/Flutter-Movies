import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/movie.dart';

const String _BASE_URL = "http://www.omdbapi.com/";
const String _API_KEY = "583ac0ed";

Future<dynamic> searchMovies(String searchKey) async {
  if (searchKey.isEmpty) {
    return "Type to search!";
  }

  final http.Response response =
      await http.get(_BASE_URL + "?s=" + searchKey + "&apikey=" + _API_KEY);

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
    list.add(Movie.fromJson(data[i]));
  }
  return list;
}
