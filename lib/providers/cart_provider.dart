import 'package:flutter/foundation.dart';
import 'package:lovely_pharma/models/cart_item_model.dart';
import 'package:lovely_pharma/models/medicine_model.dart';

class CartProvider with ChangeNotifier {
  List<CartItemModel> _items = [];
  
  List<CartItemModel> get items => _items;
  
  double get totalAmount {
    double total = 0.0;
    for (var item in _items) {
      total += item.totalPrice;
    }
    return total;
  }
  
  int get itemCount => _items.length;

  void addItem(MedicineModel medicine) {
    if (medicine.stock <= 0) return;

    var index = _items.indexWhere((item) => item.medicine.id == medicine.id);
    if (index >= 0) {
      if (_items[index].quantity < medicine.stock) {
        _items[index].quantity++;
      }
    } else {
      _items.add(CartItemModel(medicine: medicine, quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.medicine.id == id);
    notifyListeners();
  }

  void decrementQuantity(String id) {
    var index = _items.indexWhere((item) => item.medicine.id == id);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items = [];
    notifyListeners();
  }
}
