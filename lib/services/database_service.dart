import 'package:lovely_pharma/models/medicine_model.dart';
import 'package:lovely_pharma/models/order_model.dart';

class DatabaseService {
  // Stream of Medicines (Mocked)
  Stream<List<MedicineModel>> getMedicines() {
    List<MedicineModel> dummyMeds = [
      MedicineModel(id: '1', name: 'Dolo 650', price: 30, description: 'Used for fever and mild to moderate pain relief.', image: '', stock: 50, category: 'Pain Relief'),
      MedicineModel(id: '2', name: 'Crocin', price: 45, description: 'Targeted relief for headache, backache.', image: '', stock: 20, category: 'Pain Relief'),
      MedicineModel(id: '3', name: 'Volini', price: 150, description: 'Pain relief spray for muscle and joint pain.', image: '', stock: 0, category: 'Pain Relief'),
      MedicineModel(id: '4', name: 'Vicks Vaporub', price: 85, description: 'Provides relief from cold and cough.', image: '', stock: 30, category: 'Cold/Cough'),
      MedicineModel(id: '5', name: 'Band-Aid', price: 15, description: 'Waterproof bandages.', image: '', stock: 100, category: 'First Aid'),
      MedicineModel(id: '6', name: 'Nivea Soft Cream', price: 200, description: 'Light moisturizer.', image: '', stock: 15, category: 'Skin Care'),
      MedicineModel(id: '7', name: 'RedBull', price: 125, description: 'Energy Drink.', image: '', stock: 40, category: 'Energy'),
    ];
    return Stream.value(dummyMeds);
  }

  // Place an order (Mocked)
  Future<bool> placeOrder(OrderModel order) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network
    return true;
  }

  // Stream of User Orders (Mocked)
  Stream<List<OrderModel>> getUserOrders(String userId) {
    return Stream.value([]); // return empty history for mock
  }
}
