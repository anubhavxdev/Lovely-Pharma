import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lovely_pharma/providers/auth_provider.dart';
import 'package:lovely_pharma/screens/main_screen.dart';
import 'package:lovely_pharma/utils/constants.dart';
import 'package:lovely_pharma/widgets/shared_widgets.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _hostelController = TextEditingController();
  final _roomController = TextEditingController();

  void _submit() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool success = false;

    try {
      if (isLogin) {
        success = await authProvider.login(
          _emailController.text,
          _passwordController.text,
        );
      } else {
        success = await authProvider.register(
          _emailController.text,
          _passwordController.text,
          _nameController.text,
          _hostelController.text,
          _roomController.text,
        );
      }

      if (success && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: AppColors.error),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthProvider>(context).isLoading;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Icon(Icons.local_pharmacy, size: 60, color: AppColors.primary),
              const SizedBox(height: 24),
              Text(
                isLogin ? 'Welcome Back' : 'Create Account',
                style: AppTextStyles.heading.copyWith(fontSize: 32),
              ),
              const SizedBox(height: 8),
              Text(
                isLogin ? 'Login to order medicines' : 'Sign up for Campus delivery',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 40),
              
              if (!isLogin) ...[
                CustomTextField(
                  hint: 'Full Name',
                  controller: _nameController,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hint: 'Hostel Name',
                        controller: _hostelController,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextField(
                        hint: 'Room No.',
                        controller: _roomController,
                      ),
                    ),
                  ],
                ),
              ],
              
              CustomTextField(
                hint: 'Email Address',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
            ),
              CustomTextField(
                hint: 'Password',
                controller: _passwordController,
                isPassword: true,
              ),
              
              const SizedBox(height: 24),
              
              PrimaryButton(
                text: isLogin ? 'Login' : 'Sign Up',
                onPressed: _submit,
                isLoading: isLoading,
              ),
              
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(
                    isLogin 
                        ? 'Don\'t have an account? Sign Up' 
                        : 'Already have an account? Login',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
