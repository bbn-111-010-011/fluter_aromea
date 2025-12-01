// lib/models/todo.dart

/// Modèle représentant un article récupéré depuis Platzi Fake Store API.
/// On garde le nom Todo pour rester cohérent avec ton ancien projet.
class Todo {
  final int id;
  final String title;
  final num price;
  final String description;
  final String categoryName;
  final String imageUrl;

  Todo({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.categoryName,
    required this.imageUrl,
  });

  /// Fabrique un Todo à partir du JSON d un produit Platzi.
  static Todo fromJson(Map<String, dynamic> json) {
    final int id = json['id'] is int ? json['id'] as int : 0;
    final String title = json['title']?.toString() ?? '';
    final num price = json['price'] is num ? json['price'] as num : 0;
    final String description = json['description']?.toString() ?? '';

    final Map<String, dynamic>? categoryJson =
        json['category'] as Map<String, dynamic>?;
    final String categoryName = categoryJson?['name']?.toString() ?? '';

    final dynamic imagesJson = json['images'];
    String imageUrl = '';
    if (imagesJson is List && imagesJson.isNotEmpty) {
      imageUrl = imagesJson.first.toString();
    }

    return Todo(
      id: id,
      title: title,
      price: price,
      description: description,
      categoryName: categoryName,
      imageUrl: imageUrl,
    );
  }
}
