// lib/UI/card2.dart

import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../api/my_apiservice.dart';
import '../api/favorites_service.dart';
import 'detail.dart';

/// Ecran Card2 qui affiche uniquement les articles favoris.
class Ecran2 extends StatefulWidget {
  const Ecran2({super.key});

  @override
  State<Ecran2> createState() => _Ecran2State();
}

class _Ecran2State extends State<Ecran2> {
  final MyApiService _apiService = MyApiService();
  final FavoritesService _favoritesService = FavoritesService();

  late Future<List<Todo>> _futureTodos;
  Set<int> _favoriteIds = <int>{};

  @override
  void initState() {
    super.initState();
    _futureTodos = _apiService.fetchTodos();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final ids = await _favoritesService.loadFavorites();
    setState(() {
      _favoriteIds = ids;
    });
  }

  Future<void> _toggleFavorite(Todo todo) async {
    final updated = await _favoritesService.toggleFavorite(
      todo.id,
      _favoriteIds,
    );
    setState(() {
      _favoriteIds = updated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoris')),
      body: FutureBuilder<List<Todo>>(
        future: _futureTodos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Erreur lors du chargement des articles\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final todos = snapshot.data ?? <Todo>[];

          final favorites = todos
              .where((t) => _favoriteIds.contains(t.id))
              .toList();

          if (favorites.isEmpty) {
            return const Center(child: Text('Aucun favori pour le moment'));
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = favorites[index];

              return Card(
                color: Colors.white,
                elevation: 7,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: _TodoAvatar(todo: todo),
                  title: Text(
                    todo.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text('${todo.categoryName} • ${todo.price} €'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _toggleFavorite(todo);
                    },
                  ),
                  onTap: () async {
                    final isFavorite = _favoriteIds.contains(todo.id);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Detail(todo: todo, initialIsFavorite: isFavorite),
                      ),
                    );
                    _loadFavorites();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _TodoAvatar extends StatelessWidget {
  final Todo todo;

  const _TodoAvatar({required this.todo});

  @override
  Widget build(BuildContext context) {
    if (todo.imageUrl.isEmpty) {
      return CircleAvatar(
        backgroundColor: Colors.lightBlue,
        child: Text(todo.id.toString()),
      );
    }

    return CircleAvatar(
      backgroundImage: NetworkImage(todo.imageUrl),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
