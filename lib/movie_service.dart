import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_movies/movie.dart';

const String _BASE_URL = "http://www.omdbapi.com/";
const String _API_KEY = "583ac0ed";

Future<dynamic> getMovieDetail(String movieTitle) async {
  if (movieTitle.isEmpty) {
    return "Invalid movie title!";
  }

  final http.Response response =
      await http.get(_BASE_URL + "?t=" + movieTitle + "&apikey=" + _API_KEY);

  print(response.body);

  Map responseJson = json.decode(response.body.toString());
  if (responseJson["Response"] == "True") {
    Movie movie = Movie.fromJson(responseJson);
    return movie;
  } else {
    String errMessage = responseJson["Error"];
    return errMessage;
  }
}
