import 'dart:convert';

import 'package:peliculas/src/models/pelicula.dart';
import 'package:http/http.dart' as http;

class PeliculaProvider{
  String _apiKey = "995a23ed00869940870fc31bd93e9d26";
  String _url = "api.themoviedb.org";
  String _languaje ="es-ES";

  Future<List<Pelicula>> getEnCines() async{
    final url = Uri.https(_url, "3/movie/now_playing", {
      "api_key" : _apiKey,
      'languaje': _languaje
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final _peliculas = Peliculas.fromJsonList(decodedData["results"]);
    return _peliculas.items;
  }

  Future<List<Pelicula>> getPopularMovies() async {
    final url = Uri.https(_url, "3/movie/popular", {
      "api_key" : _apiKey,
      'languaje': _languaje
    });
final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final _peliculas = Peliculas.fromJsonList(decodedData["results"]);
    return _peliculas.items;

  }
    




}

