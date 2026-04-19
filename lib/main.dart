import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:lovely_pharma/providers/auth_provider.dart';
import 'package:lovely_pharma/providers/medicine_provider.dart';
import 'package:lovely_pharma/providers/cart_provider.dart';
import 'package:lovely_pharma/providers/order_provider.dart';
import 'package:lovely_pharma/providers/favorite_provider.dart';
import 'package:lovely_pharma/screens/splash_screen.dart';
import 'package:lovely_pharma/utils/constants.dart';

import 'package:lovely_pharma/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp();
    await NotificationService().initialize();
  } catch (e) {
    print('Firebase initialization failed: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MedicineProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: const LovelyPharmaApp(),
    ),
  );
}

class LovelyPharmaApp extends StatelessWidget {
  const LovelyPharmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lovely Pharma',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
