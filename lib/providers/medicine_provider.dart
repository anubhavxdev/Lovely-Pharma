import 'package:flutter/foundation.dart';
import 'package:lovely_pharma/models/medicine_model.dart';
import 'package:lovely_pharma/services/database_service.dart';

class MedicineProvider with ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  
  List<MedicineModel> _medicines = [];
  List<MedicineModel> _filteredMedicines = [];
  bool _isLoading = true;
  String _activeCategory = '';

  List<MedicineModel> get medicines => _filteredMedicines;
  bool get isLoading => _isLoading;
  String get activeCategory => _activeCategory;

  MedicineProvider() {
    _fetchMedicines();
  }

  void _fetchMedicines() {
    _dbService.getMedicines().listen((meds) {
      _medicines = meds;
      _filteredMedicines = meds;
      _isLoading = false;
      notifyListeners();
    }, onError: (e) {
      print('Error fetching medicines stream: $e');
      _isLoading = false;
      notifyListeners();
    });
  }

  void searchMedicines(String query) {
    if (query.isEmpty) {
      _applyCategoryFilter();
    } else {
      _filteredMedicines = _medicines.where((med) => 
        med.name.toLowerCase().contains(query.toLowerCase()) ||
        med.description.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }

  void setCategory(String category) {
    if (_activeCategory == category) {
      _activeCategory = ''; // toggle off
    } else {
      _activeCategory = category;
    }
    _applyCategoryFilter();
    notifyListeners();
  }

  void _applyCategoryFilter() {
    if (_activeCategory.isEmpty) {
      _filteredMedicines = _medicines;
    } else {
      _filteredMedicines = _medicines.where((med) => med.category == _activeCategory).toList();
    }
  }
}
