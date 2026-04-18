import 'package:flutter/material.dart';
import 'package:lovely_pharma/providers/auth_provider.dart';
import 'package:lovely_pharma/screens/auth_screen.dart';
import 'package:lovely_pharma/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:lovely_pharma/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    if (authProvider.isAuthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_pharmacy, size: 80, color: Colors.white),
            const SizedBox(height: 16),
            Text(
              'Lovely Pharma',
              style: AppTextStyles.heading.copyWith(color: Colors.white, fontSize: 32),
            ),
          ],
        ),
      ),
    );
  }
}
