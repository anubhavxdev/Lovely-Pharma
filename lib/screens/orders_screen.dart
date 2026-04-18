import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lovely_pharma/providers/auth_provider.dart';
import 'package:lovely_pharma/providers/order_provider.dart';
import 'package:lovely_pharma/utils/constants.dart';
import 'package:lovely_pharma/screens/tracking_screen.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = Provider.of<AuthProvider>(context, listen: false).uid;
      if (userId != null) {
        Provider.of<OrderProvider>(context, listen: false).fetchUserOrders(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: orderProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : orderProvider.userOrders.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long, size: 80, color: Colors.grey.shade300),
                      const SizedBox(height: 16),
                      Text('No previous orders found', style: AppTextStyles.subheading.copyWith(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: orderProvider.userOrders.length,
                  itemBuilder: (context, index) {
                    final order = orderProvider.userOrders[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Order ID: ${order.id.substring(0, 8).toUpperCase()}', style: AppTextStyles.subheading.copyWith(fontSize: 14)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: order.status == 'Delivered' ? AppColors.accent.withOpacity(0.1) : AppColors.warning.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  order.status,
                                  style: TextStyle(
                                    color: order.status == 'Delivered' ? AppColors.accent : AppColors.warning,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(DateFormat('dd MMM yyyy, hh:mm a').format(order.timestamp), style: AppTextStyles.body.copyWith(fontSize: 12)),
                          const Divider(height: 24),
                          ...order.items.map((item) => Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${item['quantity']}x ${item['name']}', style: AppTextStyles.body),
                                  ],
                                ),
                              )),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total', style: AppTextStyles.subheading),
                              Text('₹${order.totalPrice.toStringAsFixed(0)}', style: AppTextStyles.price),
                            ],
                          ),
                          if (order.status != 'Delivered') ...[
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => TrackingScreen(orderId: order.id)));
                                },
                                icon: const Icon(Icons.map),
                                label: const Text('Live Track Order'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
