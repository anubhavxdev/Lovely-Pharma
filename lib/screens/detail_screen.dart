import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lovely_pharma/models/medicine_model.dart';
import 'package:lovely_pharma/providers/cart_provider.dart';
import 'package:lovely_pharma/providers/favorite_provider.dart';
import 'package:lovely_pharma/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailScreen extends StatelessWidget {
  final MedicineModel medicine;

  const DetailScreen({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    bool isOutOfStock = medicine.stock <= 0;
    final favProvider = Provider.of<FavoriteProvider>(context);
    bool isFav = favProvider.isFavorite(medicine.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(medicine.name),
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? AppColors.error : AppColors.textPrimary), 
            onPressed: () {
              favProvider.toggleFavorite(medicine.id);
            }
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.white,
              child: medicine.image.isNotEmpty
                  ? CachedNetworkImage(imageUrl: medicine.image, fit: BoxFit.contain)
                  : const Icon(Icons.medication, size: 100, color: Colors.grey),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          medicine.name,
                          style: AppTextStyles.heading,
                        ),
                      ),
                      Text(
                        '₹${medicine.price.toStringAsFixed(0)}',
                        style: AppTextStyles.heading.copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (isOutOfStock)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Out of Stock', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('In Stock (${medicine.stock})', style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold)),
                    ),
                  const SizedBox(height: 24),
                  Text('Description', style: AppTextStyles.subheading),
                  const SizedBox(height: 8),
                  Text(medicine.description, style: AppTextStyles.body.copyWith(height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10, offset: const Offset(0, -5)
              )
            ]
          ),
          child: ElevatedButton(
            onPressed: isOutOfStock
                ? null
                : () {
                    Provider.of<CartProvider>(context, listen: false).addItem(medicine);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Added to Cart'),
                        backgroundColor: AppColors.primary,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(isOutOfStock ? 'Currently Unavailable' : 'Add to Cart'),
          ),
        ),
      ),
    );
  }
}
