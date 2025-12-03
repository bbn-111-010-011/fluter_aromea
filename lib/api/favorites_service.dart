// lib/api/favorites_service.dart

import 'package:shared_preferences/shared_preferences.dart';

/// Service simple pour gérer les favoris en local.
///
/// Les favoris sont stockés comme une liste d identifiants d articles
/// dans SharedPreferences sous la clé "favorite_ids".
class FavoritesService {
  static const String _prefsKey = 'favorite_ids';

  /// Charge la liste des identifiants favoris depuis SharedPreferences.
  Future<Set<int>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> stored = prefs.getStringList(_prefsKey) ?? <String>[];

    final ids = stored
        .map((s) => int.tryParse(s))
        .where((id) => id != null)
        .cast<int>()
        .toSet();

    return ids;
  }

  /// Sauvegarde une liste d identifiants favoris dans SharedPreferences.
  Future<void> saveFavorites(Set<int> ids) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> stored = ids.map((id) => id.toString()).toList();
    await prefs.setStringList(_prefsKey, stored);
  }

  /// Bascule un identifiant en favori ou non.
  /// Retourne le nouvel ensemble d identifiants favoris.
  Future<Set<int>> toggleFavorite(int id, Set<int> current) async {
    final updated = Set<int>.from(current);
    if (updated.contains(id)) {
      updated.remove(id);
    } else {
      updated.add(id);
    }
    await saveFavorites(updated);
    return updated;
  }
}
