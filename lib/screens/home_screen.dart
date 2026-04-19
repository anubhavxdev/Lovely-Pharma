import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lovely_pharma/providers/medicine_provider.dart';
import 'package:lovely_pharma/providers/auth_provider.dart';
import 'package:lovely_pharma/providers/cart_provider.dart';
import 'package:lovely_pharma/providers/favorite_provider.dart';
import 'package:lovely_pharma/models/medicine_model.dart';
import 'package:lovely_pharma/screens/detail_screen.dart';
import 'package:lovely_pharma/utils/constants.dart';
import 'package:lovely_pharma/utils/seed_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final medProvider = Provider.of<MedicineProvider>(context);
    final userProvider = Provider.of<AuthProvider>(context);
    final user = userProvider.userModel;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(
                builder: (context) {
                  String displayLocation = 'Campus Area';
                  if (user != null && user.addresses.isNotEmpty) {
                    displayLocation = '${user.addresses.first['hostel']} - Rm ${user.addresses.first['roomNo']}';
                  }
                  return _buildHeader(user?.name ?? 'Student', displayLocation);
                }
              ),
              _buildSearchBar(medProvider),
              
              if (_searchController.text.isEmpty && medProvider.activeCategory.isEmpty) ...[
                _buildBanners(),
                _buildCategories(medProvider),
                _buildSectionTitle('Trending on Campus', 'See All'),
                _buildTrendingList(context, medProvider.medicines),
                _buildSectionTitle('All Medicines', ''),
              ] else if (medProvider.activeCategory.isNotEmpty) ...[
                _buildCategories(medProvider),
                _buildSectionTitle('${medProvider.activeCategory} Medicines', ''),
              ] else ...[
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Search Results', style: AppTextStyles.heading.copyWith(fontSize: 18)),
                ),
              ],
              
              _buildMedicineGrid(medProvider),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String name, String hostel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Location Settings...')),
              );
            },
            child: Row(
              children: [
                const Icon(Icons.location_on, color: AppColors.primary, size: 28),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivering to',
                      style: AppTextStyles.body.copyWith(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      hostel,
                      style: AppTextStyles.heading.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.storage, color: AppColors.primary),
                tooltip: 'Developer: Populate Database',
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Wait... Uploading dummy medicines!')));
                  await SeedData.pushDummyMedicines();
                  if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Done! Refreshing live...')));
                },
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile options clicked')),
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(MedicineProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: TextField(
          controller: _searchController,
          onChanged: provider.searchMedicines,
          decoration: InputDecoration(
            hintText: 'Search for medicines, first aid...',
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildBanners() {
    return Container(
      height: 160,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: PageView(
        controller: PageController(viewportFraction: 0.9),
        children: [
          _buildBannerCard('Free Delivery!', 'On campus orders above ₹100', AppColors.primary),
          _buildBannerCard('Exam Season Essentials', 'Stay healthy and focused.', AppColors.accent),
        ],
      ),
    );
  }

  Widget _buildBannerCard(String title, String subtitle, Color color) {
    return GestureDetector(
      onTap: () {
        // Just acknowledging the click for UI demo
        // Would logically route to a promo page
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: const NetworkImage('https://images.unsplash.com/photo-1550572017-edb9b470bf75?w=600&q=80'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(color.withOpacity(0.6), BlendMode.dstATop),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: AppTextStyles.heading.copyWith(color: Colors.white, fontSize: 22)),
            const SizedBox(height: 8),
            Text(subtitle, style: AppTextStyles.body.copyWith(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories(MedicineProvider medProvider) {
    final categories = [
      {'icon': Icons.medical_services, 'name': 'First Aid', 'color': Colors.redAccent},
      {'icon': Icons.sick, 'name': 'Cold/Cough', 'color': Colors.blue},
      {'icon': Icons.bolt, 'name': 'Energy', 'color': Colors.orangeAccent},
      {'icon': Icons.spa, 'name': 'Skin Care', 'color': Colors.teal},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: categories.map((cat) {
          bool isActive = medProvider.activeCategory == cat['name'];
          return GestureDetector(
            onTap: () {
              medProvider.setCategory(cat['name'] as String);
            },
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: isActive ? (cat['color'] as Color) : (cat['color'] as Color).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(cat['icon'] as IconData, color: isActive ? Colors.white : (cat['color'] as Color), size: 28),
                ),
                const SizedBox(height: 8),
                Text(
                  cat['name'] as String, 
                  style: AppTextStyles.body.copyWith(
                    fontSize: 12, 
                    fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                    color: isActive ? AppColors.primary : AppColors.textSecondary
                  )
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String actionText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.heading.copyWith(fontSize: 18)),
          if (actionText.isNotEmpty)
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Loading all items...')),
                );
              },
              child: Text(actionText, style: AppTextStyles.body.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  Widget _buildTrendingList(BuildContext context, List<MedicineModel> medicines) {
    if (medicines.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 220,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: medicines.length > 3 ? 3 : medicines.length,
        itemBuilder: (context, index) {
          final medicine = medicines[index];
          return Container(
            width: 160,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: _buildMedicineCard(context, medicine),
          );
        },
      ),
    );
  }

  Widget _buildMedicineGrid(MedicineProvider provider) {
    if (provider.isLoading) {
      return const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator()));
    }
    
    if (provider.medicines.isEmpty) {
      return const Center(child: Padding(padding: EdgeInsets.all(40), child: Text('No medicines found')));
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: provider.medicines.length,
      itemBuilder: (context, index) {
        return _buildMedicineCard(context, provider.medicines[index]);
      },
    );
  }

  Widget _buildMedicineCard(BuildContext context, MedicineModel medicine) {
    bool isOutOfStock = medicine.stock <= 0;
    final favProvider = Provider.of<FavoriteProvider>(context);
    bool isFav = favProvider.isFavorite(medicine.id);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailScreen(medicine: medicine)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: medicine.image.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: medicine.image,
                              fit: BoxFit.contain,
                              errorWidget: (context, url, err) => const Icon(Icons.medical_information, size: 50, color: Colors.grey),
                            )
                          : const Icon(Icons.medical_information, size: 50, color: Colors.grey),
                  ),
                  if (isOutOfStock)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('Out of Stock', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  Positioned(
                    top: 8, left: 8,
                    child: GestureDetector(
                      onTap: () {
                        favProvider.toggleFavorite(medicine.id);
                      },
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        padding: const EdgeInsets.all(4),
                        child: Icon(isFav ? Icons.favorite : Icons.favorite_border, size: 16, color: isFav ? AppColors.error : Colors.grey),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicine.name,
                    style: AppTextStyles.subheading.copyWith(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${medicine.price.toStringAsFixed(0)}',
                        style: AppTextStyles.price,
                      ),
                      GestureDetector(
                        onTap: isOutOfStock ? null : () {
                          Provider.of<CartProvider>(context, listen: false).addItem(medicine);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added ${medicine.name} to Cart'),
                              backgroundColor: AppColors.primary,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(color: isOutOfStock ? Colors.grey : AppColors.primary, borderRadius: BorderRadius.circular(6)),
                          child: const Icon(Icons.add, color: Colors.white, size: 16),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
