import 'package:http/http.dart' as http;
import 'dart:convert';
import 'movie.dart';

const String _BASE_URL = "http://www.omdbapi.com/";
const String _API_KEY = "583ac0ed";

Future<Movie> getMovieDetail(String movieTitle) async {
  final http.Response response =
      await http.get(_BASE_URL + "?t=" + movieTitle + "&apikey=" + _API_KEY);

  print("Request: ${response.request.url}");
  print("Response: ${response.body}");

  Map responseJson = json.decode(response.body.toString());
  if (responseJson["Response"] == "True") {
    Movie movie = Movie.fromJson(responseJson);
    return movie;
  } else {
    return Movie.empty();
  }
}
