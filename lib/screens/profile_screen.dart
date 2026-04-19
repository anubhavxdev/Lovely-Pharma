import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lovely_pharma/providers/auth_provider.dart';
import 'package:lovely_pharma/screens/auth_screen.dart';
import 'package:lovely_pharma/screens/favorites_screen.dart';
import 'package:lovely_pharma/utils/constants.dart';
import 'package:lovely_pharma/widgets/shared_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  void _showAddAddressDialog(BuildContext context, String uid, List<Map<String, String>> currentAddresses) {
    final hostelController = TextEditingController();
    final roomController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add New Address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(hint: 'Hostel Name', controller: hostelController),
            const SizedBox(height: 16),
            CustomTextField(hint: 'Room Number', controller: roomController),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () async {
              if (hostelController.text.isNotEmpty && roomController.text.isNotEmpty) {
                final newAddress = {
                  'hostel': hostelController.text.trim(),
                  'roomNo': roomController.text.trim(),
                };
                final updatedAddresses = List<Map<String, String>>.from(currentAddresses)..add(newAddress);
                
                await FirebaseFirestore.instance.collection('users').doc(uid).update({
                  'addresses': updatedAddresses,
                });
                
                // Technically we should update `UserModel` in `AuthProvider`, but rebuilding triggers auth state refresh
                if (mounted) Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).userModel;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.primary,
                          child: Icon(Icons.person, size: 50, color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        Text(user.name, style: AppTextStyles.heading),
                        Text(user.email, style: AppTextStyles.body),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Saved Addresses', style: AppTextStyles.heading),
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: AppColors.primary),
                        onPressed: () => _showAddAddressDialog(context, user.uid, user.addresses),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  if (user.addresses.isEmpty)
                    const Text('No saved addresses.', style: TextStyle(fontStyle: FontStyle.italic))
                  else
                    ...user.addresses.map((addr) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300)
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on, color: AppColors.primary),
                            const SizedBox(width: 12),
                            Text('${addr["hostel"]} - Room ${addr["roomNo"]}', style: AppTextStyles.body),
                          ],
                        ),
                      ),
                    )),

                  const SizedBox(height: 24),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesScreen()));
                    },
                    child: _buildProfileItem(Icons.favorite, 'My Favorites', 'View saved medicines'),
                  ),
                  const Divider(),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        await Provider.of<AuthProvider>(context, listen: false).logout();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const AuthScreen()),
                          (route) => false,
                        );
                      },
                      child: const Text('Log Out'),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.body.copyWith(fontSize: 12)),
              Text(value, style: AppTextStyles.subheading.copyWith(fontSize: 16)),
            ],
          )
        ],
      ),
    );
  }
}
