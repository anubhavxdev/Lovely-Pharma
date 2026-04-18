import 'package:lovely_pharma/models/medicine_model.dart';

class CartItemModel {
  final MedicineModel medicine;
  int quantity;

  CartItemModel({
    required this.medicine,
    this.quantity = 1,
  });

  double get totalPrice => medicine.price * quantity;
}
