import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula.dart';
import 'package:peliculas/src/providers/pelicula_provider.dart';

class DataSearch extends SearchDelegate {
  String seleccion = "";

  PeliculaProvider pp = PeliculaProvider();

  final pelicula = [
    'fdsfsd',
    'fdsfdfd',
    'fdsfdsfds',
    'fdsfds',
    'fdsfdsfds',
    ];

      final peliculasRecientes = [
    'fdfds',
    'fdfds',
    'fdsdsfds',
    'fdsfdsfds',
    'fdsfdsfds',
    ];
  
  @override
  List<Widget> buildActions(BuildContext context) {
      // TODO: implement buildActions
      return [
        IconButton(
          icon:  Icon(Icons.clear),
          onPressed: (){
print("clear");
            query = '';
          },
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext contexntext) {
      // TODO: implement buildLeading
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
       
      ),
      onPressed: (){
        close(contexntext, null);

      }
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // TODO: implement buildResults
      return Center(
        child: Container(child: Text(seleccion, style: TextStyle(
          fontSize: 16.0
        ) ,),),
      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {

    //   final listaSugerida = query.isEmpty ? peliculasRecientes : peliculasRecientes.where(
    //     (p) => p.toLowerCase().startsWith(query.toLowerCase())
    //     ).toList();
    
    // return ListView.builder(
    //   itemCount: listaSugerida.length,
    //   itemBuilder: (context, i){
    //     return ListTile(
    //       leading: Icon(Icons.movie),
    //       title: Text( listaSugerida[i]),
    //       onTap: (){
    //         seleccion = listaSugerida[i];
    //         showResults(context);
    //       },
    //     );
    //   },
    // );

    if (query.isEmpty){
      return Container(

      );
    }

    return FutureBuilder(
      future: pp.BuscarPelicula(query),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        
        if (snapshot.hasData) {

          final _peliculas = snapshot.data;

          return ListView(
            children: _peliculas.map( (x){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(x.gePosterImg()),
                  placeholder: AssetImage("assets/img/no-image.jpg") ,
                  fit: BoxFit.contain,
                  height: 50.0,
                ),
                title: Text(x.title),
                subtitle: Text(x.originalTitle),
                onTap:(){
                  close(context, null);
                  x.uniqueId = "";
                  Navigator.pushNamed(context, 'detalle' , arguments:  x);
                } ,
              );
            } ).toList() ,
          );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

}