import 'package:flutter/material.dart';
import 'package:peliculas/src/delegates/search_delegate.dart';
import 'package:peliculas/src/models/pelicula.dart';
import 'package:peliculas/src/providers/pelicula_provider.dart';
import 'package:peliculas/src/widget/card_swiper_widget.dart';
import 'package:peliculas/src/widget/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final pp = PeliculaProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Peliculas en Cine"),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch(), query: ''

              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: pp.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            peliculas: snapshot.data,
          );
        }

        return Container( height: 40.0, child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _footer(BuildContext context) {

    pp.getPopularMovies();

    return Container(
      width: double.infinity,
      child: Column(
        //crossAxisAlignment: C,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10.0),
            child: Text("Populares" , style: Theme.of(context).textTheme.subhead, )),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: pp.popularesStream,
            // future: pp.getPopularMovies(),
            //initialData: [],
            builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal( peliculas :   snapshot.data, siguientePagina:  pp.getPopularMovies);
              }
              return CircularProgressIndicator(
                
              );
            },
          ),
        ],
      ),
    );
  }
}
