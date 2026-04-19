import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lovely_pharma/providers/favorite_provider.dart';
import 'package:lovely_pharma/providers/medicine_provider.dart';
import 'package:lovely_pharma/screens/detail_screen.dart';
import 'package:lovely_pharma/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoriteProvider>(context);
    final medProvider = Provider.of<MedicineProvider>(context, listen: false);

    final favMeds = medProvider.medicines.where((med) => favProvider.isFavorite(med.id)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Medicines')),
      body: favMeds.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text('No saved items yet!', style: AppTextStyles.subheading.copyWith(color: Colors.grey)),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(24),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: favMeds.length,
              itemBuilder: (context, index) {
                final medicine = favMeds[index];
                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(medicine: medicine))),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: const BorderRadius.vertical(top: Radius.circular(16))),
                          child: medicine.image.isNotEmpty 
                            ? CachedNetworkImage(imageUrl: medicine.image, fit: BoxFit.contain)
                            : const Icon(Icons.medical_information, size: 50, color: Colors.grey),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(medicine.name, style: AppTextStyles.subheading.copyWith(fontSize: 14), maxLines: 1),
                              const SizedBox(height: 4),
                              Text('₹${medicine.price.toStringAsFixed(0)}', style: AppTextStyles.price),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
