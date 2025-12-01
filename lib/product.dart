// lib/product.dart

import 'package:flutter/material.dart';

/// Représente la catégorie d un produit.
/// Cette classe correspond au champ "category" dans le JSON de l API.
class ProductCategory {
  final int id;
  final String name;
  final String image;
  final String slug;

  ProductCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.slug,
  });

  /// Constructeur factory qui convertit une Map JSON en objet ProductCategory.
  /// On utilise les opérateurs as pour caster et ?? pour fournir une valeur
  /// par défaut si la donnée est absente.
  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
    );
  }
}

/// Représente un produit complet.
/// Cette classe correspond à la structure JSON renvoyée par
/// l endpoint https://api.escuelajs.co/api/v1/products
class Product {
  final int id;
  final String title;
  final String slug;
  final num price;
  final String description;
  final ProductCategory category;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  /// Constructeur factory qui convertit une Map JSON en objet Product.
  /// On transforme ici la liste "images" en List<String>.
  factory Product.fromJson(Map<String, dynamic> json) {
    final imagesJson = json['images'];

    // Si "images" est bien une liste, on la mappe en liste de String.
    // Sinon on renvoie une liste vide pour éviter les erreurs.
    final List<String> imagesList = imagesJson is List
        ? imagesJson.map((e) => e.toString()).toList()
        : <String>[];

    return Product(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      price: json['price'] as num? ?? 0,
      description: json['description'] as String? ?? '',
      category:
          ProductCategory.fromJson(json['category'] as Map<String, dynamic>),
      images: imagesList,
    );
  }

  /// Renvoie la première image du produit.
  /// Si la liste est vide, renvoie une chaîne vide.
  String get mainImage {
    if (images.isNotEmpty) {
      return images.first;
    }
    return '';
  }

  /// Génère une couleur à partir de l identifiant du produit.
  /// Cette couleur n est pas indispensable, elle permet juste d apporter
  /// un accent visuel cohérent par produit.
  Color get accentColor {
    final int value = 0xFF000000 | ((id * 1234567) & 0x00FFFFFF);
    return Color(value);
  }
}
