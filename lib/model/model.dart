class RecipeModel {
  late String publisher;
  // late List ingridients;
  // late String source_url;
  late String img_url;
  late String title;
  // late int servings;
  // late int cooking_time;
  late String id;
  RecipeModel({
    required this.publisher,
    // required this.ingridients,
    // required this.source_url,
    required this.img_url,
    required this.title,
    // required this.servings,
    // required this.cooking_time,
    required this.id,
  });
  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
        publisher: json['publisher'],
        // ingridients: json['ingredients'],
        // source_url: json['source_url'],
        img_url: json['image_url'],
        title: json['title'],
        // servings: json['servings'],
        // cooking_time: json['cooking_time'],
        id: json['id']);
  }
}

class RecipesModel {
  late String publisher;
  late List ingridients;
  late String source_url;
  late String img_url;
  late String title;
  late int servings;
  late int cooking_time;
  late String id;
  RecipesModel({
    required this.publisher,
    required this.ingridients,
    required this.source_url,
    required this.img_url,
    required this.title,
    required this.servings,
    required this.cooking_time,
    required this.id,
  });
  factory RecipesModel.fromJson(Map<String, dynamic> json) {
    return RecipesModel(
        publisher: json['publisher'],
        ingridients: json['ingredients'],
        source_url: json['source_url'],
        img_url: json['image_url'],
        title: json['title'],
        servings: json['servings'],
        cooking_time: json['cooking_time'],
        id: json['id']);
  }
}
