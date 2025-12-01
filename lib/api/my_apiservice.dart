// lib/api/my_apiservice.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/todo.dart';

/// Service qui encapsule l appel à Platzi Fake Store API.
///
/// L URL donnée dans le sujet est
///   https://fakeapi.platzi.com/   (site de documentation)
///
/// Les données JSON sont servies par
///   https://api.escuelajs.co/api/v1   (service REST)
class MyApiService {
  static const String _baseUrl = 'https://api.escuelajs.co/api/v1';

  /// Récupère la liste des articles depuis l endpoint /products.
  Future<List<Todo>> fetchTodos() async {
    final uri = Uri.parse('$_baseUrl/products');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Décodage du corps JSON en liste dynamique
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

      // Transformation de chaque élément en Todo
      return data
          .map(
            (item) => Todo.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw Exception(
        'Erreur lors du chargement des articles code ${response.statusCode}',
      );
    }
  }
}
