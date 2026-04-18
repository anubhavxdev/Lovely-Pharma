import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lovely_pharma/providers/auth_provider.dart';
import 'package:lovely_pharma/screens/auth_screen.dart';
import 'package:lovely_pharma/screens/favorites_screen.dart';
import 'package:lovely_pharma/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(user.name, style: AppTextStyles.heading),
                  Text(user.email, style: AppTextStyles.body),
                  const SizedBox(height: 32),
                  _buildProfileItem(Icons.apartment, 'Hostel', user.hostel),
                  const Divider(),
                  _buildProfileItem(Icons.door_front_door, 'Room Number', user.roomNo),
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
