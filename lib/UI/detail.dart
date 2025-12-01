// lib/UI/detail.dart

import 'package:flutter/material.dart';

import '../models/todo.dart';

/// Page de détail pour un article Todo issu de l API Platzi.
class Detail extends StatelessWidget {
  final Todo todo;

  const Detail({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Article ${todo.title}')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _ImageCard(todo: todo),

            Card(
              color: Colors.lightBlue,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.key),
                title: const Text('Identifiant'),
                subtitle: Text('${todo.id}'),
              ),
            ),
            Card(
              color: Colors.lightBlue,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.title),
                title: const Text('Titre de l article'),
                subtitle: Text(todo.title),
              ),
            ),
            Card(
              color: Colors.lightBlue,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.description),
                title: const Text('Description'),
                subtitle: Text(todo.description),
              ),
            ),
            Card(
              color: Colors.lightBlue,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.category),
                title: const Text('Catégorie'),
                subtitle: Text(todo.categoryName),
              ),
            ),
            Card(
              color: Colors.lightBlue,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.euro),
                title: const Text('Prix'),
                subtitle: Text('${todo.price} €'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Carte en haut de la page pour afficher l image principale de l article.
class _ImageCard extends StatelessWidget {
  final Todo todo;

  const _ImageCard({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 7,
      margin: const EdgeInsets.all(10),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: todo.imageUrl.isEmpty
            ? Container(
                color: Colors.grey.shade200,
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 48,
                  ),
                ),
              )
            : Image.network(
                todo.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  final expected = loadingProgress.expectedTotalBytes;
                  final loaded = loadingProgress.cumulativeBytesLoaded;
                  final value = expected != null && expected != 0
                      ? loaded / expected
                      : null;
                  return Center(
                    child: CircularProgressIndicator(value: value),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 48,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
