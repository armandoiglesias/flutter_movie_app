import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula.dart';
import 'package:peliculas/src/providers/pelicula_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10.0,
              ),
              _posterTitulo(context, pelicula),
              _descripcionPelicula(context, pelicula),
              // _descripcionPelicula(context, pelicula),
              // _descripcionPelicula(context, pelicula),
              // _descripcionPelicula(context, pelicula),
              // _descripcionPelicula(context, pelicula),
              // _descripcionPelicula(context, pelicula),
              // _descripcionPelicula(context, pelicula),
              _crearCasting(context, pelicula.id),
            ]),
          )
        ],
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula p) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(children: <Widget>[
        Hero(
          tag: p.uniqueId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(p.gePosterImg()),
              height: 150.0,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Flexible(
          child: Column(
            children: <Widget>[
              Text(
                p.title,
                style: Theme.of(context).textTheme.title,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                p.originalTitle,
                style: Theme.of(context).textTheme.subhead,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.star_border),
                  Text(
                    p.voteAverage.toString(),
                    style: Theme.of(context).textTheme.subhead,
                  )
                ],
              )
            ],
          ),
        )
      ]),
    );
  }

  Widget _crearAppBar(Pelicula p) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          p.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(p.geBackgroundImg()),
          placeholder: AssetImage("assets/img/loading.gif"),
          fadeInDuration: Duration(milliseconds: 250),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _descripcionPelicula(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(BuildContext context, int id) {
    final pp = PeliculaProvider();
    return FutureBuilder(
      future: pp.getCast(id.toString()),
      // initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> data) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        itemCount: data.length,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemBuilder: (context, i) {
          //return Text("gola");
          return _actorTarjeta(data[i]);
        },
      ),
    );
  }

  Widget _actorTarjeta(Actor a) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
                image: NetworkImage(a.getPhotoImg()),
                placeholder: AssetImage("assets/img/no-image.jpg"),
                height: 150.0,
                fit: BoxFit.cover),
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            a.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
