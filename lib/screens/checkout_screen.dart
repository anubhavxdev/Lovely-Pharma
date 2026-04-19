import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:lovely_pharma/providers/auth_provider.dart';
import 'package:lovely_pharma/providers/cart_provider.dart';
import 'package:lovely_pharma/providers/order_provider.dart';
import 'package:lovely_pharma/models/order_model.dart';
import 'package:lovely_pharma/screens/main_screen.dart';
import 'package:lovely_pharma/screens/tracking_screen.dart';
import 'package:lovely_pharma/services/storage_service.dart';
import 'package:lovely_pharma/utils/constants.dart';
import 'package:lovely_pharma/widgets/shared_widgets.dart';
import 'package:uuid/uuid.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _isLoading = false;
  bool _requiresPrescription = false;
  File? _prescriptionImage;
  final ImagePicker _picker = ImagePicker();
  final StorageService _storageService = StorageService();

  List<Map<String, String>> _addresses = [];
  Map<String, String>? _selectedAddress;

  @override
  void initState() {
    super.initState();
    // Prefill data
    final user = Provider.of<AuthProvider>(context, listen: false).userModel;
    if (user != null) {
      _addresses = user.addresses;
      if (_addresses.isNotEmpty) {
        _selectedAddress = _addresses.first;
      }
    }
    
    // Check if prescription is required
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    _requiresPrescription = cartProvider.items.any((item) => item.medicine.requiresPrescription);
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _prescriptionImage = File(pickedFile.path);
      });
    }
  }

  void _placeOrder() async {
    if (_selectedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a delivery address')));
      return;
    }

    if (_requiresPrescription && _prescriptionImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please upload a prescription for restricted medicines')));
      return;
    }

    setState(() => _isLoading = true);

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    final String orderId = const Uuid().v4();
    String? prescriptionUrl;

    if (_requiresPrescription && _prescriptionImage != null) {
      prescriptionUrl = await _storageService.uploadPrescription(_prescriptionImage!, orderId);
      if (prescriptionUrl == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to upload prescription')));
          setState(() => _isLoading = false);
        }
        return;
      }
    }

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
      hostel: _selectedAddress!['hostel'] ?? '',
      roomNo: _selectedAddress!['roomNo'] ?? '',
      prescriptionUrl: prescriptionUrl,
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
            Text('Delivery Address', style: AppTextStyles.heading),
            const SizedBox(height: 16),
            if (_addresses.isEmpty)
              const Text('No addresses found. Please add one in Profile.')
            else
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<Map<String, String>>(
                  isExpanded: true,
                  value: _selectedAddress,
                  underline: const SizedBox(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedAddress = newValue;
                    });
                  },
                  items: _addresses.map<DropdownMenuItem<Map<String, String>>>((address) {
                    return DropdownMenuItem<Map<String, String>>(
                      value: address,
                      child: Text('${address['hostel']} - Room ${address['roomNo']}'),
                    );
                  }).toList(),
                ),
              ),
            
            if (_requiresPrescription) ...[
              const SizedBox(height: 24),
              Text('Prescription Required', style: AppTextStyles.heading.copyWith(color: Colors.red)),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.withOpacity(0.5)),
                  ),
                  child: _prescriptionImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(_prescriptionImage!, fit: BoxFit.cover),
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, size: 40, color: Colors.red),
                            SizedBox(height: 8),
                            Text('Tap to upload prescription', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                ),
              ),
            ],

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
