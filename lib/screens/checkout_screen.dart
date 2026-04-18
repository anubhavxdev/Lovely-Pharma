import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lovely_pharma/providers/auth_provider.dart';
import 'package:lovely_pharma/providers/cart_provider.dart';
import 'package:lovely_pharma/providers/order_provider.dart';
import 'package:lovely_pharma/models/order_model.dart';
import 'package:lovely_pharma/screens/main_screen.dart';
import 'package:lovely_pharma/screens/tracking_screen.dart';
import 'package:lovely_pharma/utils/constants.dart';
import 'package:lovely_pharma/widgets/shared_widgets.dart';
import 'package:uuid/uuid.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _hostelController = TextEditingController();
  final _roomController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Prefill data
    final user = Provider.of<AuthProvider>(context, listen: false).userModel;
    if (user != null) {
      _hostelController.text = user.hostel;
      _roomController.text = user.roomNo;
    }
  }

  void _placeOrder() async {
    if (_hostelController.text.isEmpty || _roomController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all delivery details')));
      return;
    }

    setState(() => _isLoading = true);

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    final String orderId = const Uuid().v4();
    final itemsMap = cartProvider.items.map((item) => {
      'id': item.medicine.id,
      'name': item.medicine.name,
      'price': item.medicine.price,
      'quantity': item.quantity,
    }).toList();

    OrderModel order = OrderModel(
      id: orderId,
      userId: userProvider.uid ?? '',
      items: itemsMap,
      totalPrice: cartProvider.totalAmount,
      status: 'Pending',
      timestamp: DateTime.now(),
      hostel: _hostelController.text,
      roomNo: _roomController.text,
    );

    bool success = await orderProvider.placeNewOrder(order);

    if (success && mounted) {
      cartProvider.clearCart();
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Icon(Icons.check_circle, color: AppColors.accent, size: 60),
          content: const Text('Order Placed Successfully!', textAlign: TextAlign.center),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MainScreen()), 
                  (Route<dynamic> route) => false
                );
                Navigator.push(context, MaterialPageRoute(builder: (_) => TrackingScreen(orderId: orderId)));
              },
              child: const Text('Track Order', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MainScreen()), 
                  (Route<dynamic> route) => false
                );
              },
              child: const Text('Back to Home'),
            )
          ],
        )
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to place order')));
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Delivery Details', style: AppTextStyles.heading),
            const SizedBox(height: 16),
            CustomTextField(hint: 'Hostel Name', controller: _hostelController),
            CustomTextField(hint: 'Room Number', controller: _roomController),
            
            const SizedBox(height: 24),
            Text('Order Summary', style: AppTextStyles.heading),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ...cartProvider.items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${item.quantity}x ${item.medicine.name}', style: AppTextStyles.body),
                        Text('₹${item.totalPrice.toStringAsFixed(0)}', style: AppTextStyles.body),
                      ],
                    ),
                  )),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total to Pay (COD)', style: AppTextStyles.subheading),
                      Text('₹${cartProvider.totalAmount.toStringAsFixed(0)}', style: AppTextStyles.price),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            PrimaryButton(
              text: 'Place Order (Cash on Delivery)',
              onPressed: _placeOrder,
              isLoading: _isLoading,
            )
          ],
        ),
      ),
    );
  }
}
