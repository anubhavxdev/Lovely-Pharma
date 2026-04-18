import 'package:flutter/foundation.dart';
import 'package:lovely_pharma/models/order_model.dart';
import 'package:lovely_pharma/services/database_service.dart';

class OrderProvider with ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  
  List<OrderModel> _userOrders = [];
  bool _isLoading = false;

  List<OrderModel> get userOrders => _userOrders;
  bool get isLoading => _isLoading;

  void fetchUserOrders(String userId) {
    _isLoading = true;
    notifyListeners();

    _dbService.getUserOrders(userId).listen((orders) {
      _userOrders = orders;
      _isLoading = false;
      notifyListeners();
    }, onError: (e) {
      print('Error fetching orders: $e');
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<bool> placeNewOrder(OrderModel order) async {
    return await _dbService.placeOrder(order);
  }
}
