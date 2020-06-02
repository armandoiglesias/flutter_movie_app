import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/pelicula.dart';
import 'package:http/http.dart' as http;

class PeliculaProvider {
  String _apiKey = "995a23ed00869940870fc31bd93e9d26";
  String _url = "api.themoviedb.org";
  String _languaje = "es-ES";

  int _popularPage = 0;

  bool cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

void disposeStream(){
  _popularesStreamController.close();
}

Future<List<Pelicula>> _resultados(Uri uri) async{

  final resp = await http.get(uri);
    final decodedData = json.decode(resp.body);
    final _peliculas = Peliculas.fromJsonList(decodedData["results"]);
    return _peliculas.items; 
}

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, "3/movie/now_playing",
        {"api_key": _apiKey, 'languaje': _languaje});

    // final resp = await http.get(url);
    // final decodedData = json.decode(resp.body);
    // final _peliculas = Peliculas.fromJsonList(decodedData["results"]);
    // return _peliculas.items;

    return await _resultados(url);
  }

  Future<List<Pelicula>> getPopularMovies() async {
    
    if(cargando){
      return [];
    }

    cargando = true;
    _popularPage++;

    final url = Uri.https(_url, "3/movie/popular", {
      "api_key": _apiKey,
      'languaje': _languaje,
      "page": _popularPage.toString()
    });

    // final resp = await http.get(url);
    // final decodedData = json.decode(resp.body);
    // final _peliculas = Peliculas.fromJsonList(decodedData["results"]);
    // return _peliculas.items;

    final _resp =  await _resultados(url);
    _populares.addAll(_resp);
    popularesSink(_populares);

    cargando = false;
    
    return _resp;
  }
}
