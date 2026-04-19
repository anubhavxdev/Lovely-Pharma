import 'package:lovely_pharma/models/medicine_model.dart';
import 'package:lovely_pharma/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream of Medicines
  Stream<List<MedicineModel>> getMedicines() {
    return _firestore.collection('medicines').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => MedicineModel.fromMap(doc.data(), doc.id)).toList();
    });
  }

  // Place an order
  Future<bool> placeOrder(OrderModel order) async {
    try {
      await _firestore.collection('orders').doc(order.id).set(order.toMap());
      return true;
    } catch (e) {
      print('Error placing order: $e');
      return false;
    }
  }

  // Stream of User Orders
  Stream<List<OrderModel>> getUserOrders(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => OrderModel.fromMap(doc.data(), doc.id)).toList();
    });
  }
}
