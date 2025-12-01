// lib/UI/card1.dart

import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../api/my_apiservice.dart';
import 'detail.dart';

/// Ecran Card1 qui affiche la liste des articles venant de l API Platzi.
class Ecran1 extends StatefulWidget {
  const Ecran1({super.key});

  @override
  State<Ecran1> createState() => _Ecran1State();
}

class _Ecran1State extends State<Ecran1> {
  // Service API
  final MyApiService _apiService = MyApiService();

  // Future pour le chargement des articles
  late Future<List<Todo>> _futureTodos;

  @override
  void initState() {
    super.initState();
    // On déclenche l appel à l API au démarrage de l écran
    _futureTodos = _apiService.fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles (API Platzi)'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: _futureTodos,
        builder: (context, snapshot) {
          // En cours de chargement
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Erreur
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

          final todos = snapshot.data;

          // Aucune donnée
          if (todos == null || todos.isEmpty) {
            return const Center(
              child: Text('Aucun article disponible'),
            );
          }

          // Liste des articles dans des Card comme ton TD initial
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = todos[index];
              return Card(
                color: Colors.white,
                elevation: 7,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  // Avatar à gauche: soit image, soit id
                  leading: _TodoAvatar(todo: todo),
                  title: Text(
                    todo.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Sous titre: catégorie + prix
                  subtitle: Text('${todo.categoryName} • ${todo.price} €'),
                  trailing: const Icon(Icons.chevron_right),
                  // Clic: on va sur la page de détail
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(todo: todo),
                      ),
                    );
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

/// Avatar pour chaque article de la liste: image si dispo sinon id.
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
