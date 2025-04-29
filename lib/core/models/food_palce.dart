class FoodPlace {

  String? id;
  String? name;
  String? description;
  String? photo;


  FoodPlace({
   required this.id,
   required this.name,
  required  this.description,
  required  this.photo,
  });
  
  factory FoodPlace.fromJson(Map<String, dynamic> j) => FoodPlace(
        id: j['id'] as String,
        name: j['name'] as String,
        description: j['description'] as String,
        photo: j['photo'] as String,
      );
}