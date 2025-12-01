// lib/product_service.dart

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'product.dart';

/// Service chargé d appeler Platzi Fake Store API.
/// Ici on gère uniquement la consultation des produits.
class ProductService {
  /// Base de l API Platzi.
  /// Documentation officielle:
  /// https://fakeapi.platzi.com/en/rest/products
  static const String _baseUrl = 'https://api.escuelajs.co/api/v1';

  /// Récupère la liste complète des produits.
  /// Retourne un Future contenant une List<Product>.
  Future<List<Product>> fetchProducts() async {
    final uri = Uri.parse('$_baseUrl/products');

    // Appel HTTP GET.
    final response = await http.get(uri);

    // Si le code HTTP est 200, on considère que tout s est bien passé.
    if (response.statusCode == 200) {
      // Décodage du corps de la réponse en JSON.
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

      // Transformation de chaque élément JSON en objet Product.
      final products = data
          .map(
            (item) => Product.fromJson(item as Map<String, dynamic>),
          )
          .toList();

      return products;
    } else {
      // En cas d erreur HTTP, on lève une exception pour que la vue puisse
      // afficher un message approprié.
      throw Exception(
        'Erreur lors du chargement des produits (code ${response.statusCode})',
      );
    }
  }

  /// Récupère un produit précis via son identifiant.
  /// Cette méthode n est pas obligatoire pour la fonctionnalité 1
  /// mais elle peut servir plus tard si tu veux rafraîchir un produit
  /// depuis sa page de détail.
  Future<Product> fetchProductById(int id) async {
    final uri = Uri.parse('$_baseUrl/products/$id');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return Product.fromJson(data);
    } else {
      throw Exception(
        'Erreur lors du chargement du produit $id (code ${response.statusCode})',
      );
    }
  }
}
