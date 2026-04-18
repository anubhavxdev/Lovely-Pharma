import 'package:flutter/foundation.dart';

class FavoriteProvider with ChangeNotifier {
  final Set<String> _favoriteIds = {};

  Set<String> get favoriteIds => _favoriteIds;

  bool isFavorite(String medicineId) {
    return _favoriteIds.contains(medicineId);
  }

  void toggleFavorite(String medicineId) {
    if (_favoriteIds.contains(medicineId)) {
      _favoriteIds.remove(medicineId);
    } else {
      _favoriteIds.add(medicineId);
    }
    notifyListeners();
  }
}
