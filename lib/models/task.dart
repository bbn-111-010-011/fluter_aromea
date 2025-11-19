import 'package:flutter/material.dart';

class Task {
  int id;
  String title;
  List<String> tags;
  int nbhours;
  int difficulty;
  String description;
  Color color;

  Task({
    required this.id,
    required this.title,
    required this.tags,
    required this.nbhours,
    required this.difficulty,
    required this.description,
    required this.color,
  });

  // Méthode statique pour générer une liste de tâches
  static List<Task> generateTask(int count) {
    List<Task> tasks = [];
    for (int n = 0; n < count; n++) {
      tasks.add(
        Task(
          id: n,
          title: "Title $n",
          tags: ['tag $n', 'tag ${n + 1}'],
          nbhours: n,
          difficulty: n % 5 + 1, // Exemple de difficulté de 1 à 5
          description: "Description $n",
          color: Colors.lightBlue,
        ),
      );
    }
    return tasks;
  }

  // Méthode statique pour créer une tâche à partir d'un JSON
  static Task fromJson(Map<String, dynamic> json) {
    final tags = (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? [];

    return Task(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      tags: tags,
      nbhours: json['nbhours'] ?? 0,
      difficulty: json['difficulty'] ?? 1,
      description: json['description'] ?? '',
      color: json['color'] != null
          ? Color(int.parse(json['color'], radix: 16))
          : Colors.greenAccent,
    );
  }

  // (Optionnel) Conversion inverse vers JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'tags': tags,
      'nbhours': nbhours,
      'difficulty': difficulty,
      'description': description,
      'color': color.value.toRadixString(16),
    };
  }
}
