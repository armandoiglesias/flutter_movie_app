class Cast {
  List<Actor> actores = List();

  Cast.fromJsonList( List<dynamic> jsonList ){
    if (jsonList == null) {
      return;
    }

    for (var item in jsonList) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    }

  }

}


class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap( Map<String, dynamic> json ){
    castId= json["cast_id"];
    character= json["character"];
    creditId= json["credit_id"];
    gender= json["gender"];
    id= json["id"];
    name= json["name"];
    order= json["order"];
    profilePath= json["profile_path"];
  }

  getPhotoImg(){

    if ( profilePath != null)
      return "https://image.tmdb.org/t/p/w500/$profilePath";

    return "https://pbs.twimg.com/profile_images/1107441480145227779/q6qOw0yj_400x400.jpg";
  }
}

