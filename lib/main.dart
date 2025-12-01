// lib/main.dart

// Import du framework Flutter (widgets, MaterialApp, ThemeData, etc.).
import 'package:flutter/material.dart';

// Import de ton écran principal qui affiche la liste des articles.
import 'UI/card1.dart';

void main() {
  // Point d'entrée de l'application Flutter.
  // runApp "installe" MyApp comme widget racine.
  runApp(const MyApp());
}

/// Widget racine de l'application.
/// On utilise MaterialApp pour configurer le thème et l'écran de départ.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BTS SIO Store',
      // Thème global (Material 3 activé).
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      // Écran de démarrage de l'application.
      // Ecran1 se trouve dans lib/UI/card1.dart
      home: const Ecran1(),
    );
  }
}
