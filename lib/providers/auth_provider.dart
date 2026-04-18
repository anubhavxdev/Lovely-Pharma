import 'package:flutter/foundation.dart';
import 'package:lovely_pharma/models/user_model.dart';
import 'package:lovely_pharma/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  
  UserModel? _userModel;
  bool _isLoading = false;
  
  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _userModel != null;
  String? get uid => _authService.currentUid;

  AuthProvider() {
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    String? currentUid = _authService.currentUid;
    if (currentUid != null) {
      _isLoading = true;
      notifyListeners();
      
      _userModel = await _authService.getUserDetails(currentUid);
      
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    try {
      _userModel = await _authService.loginWithEmailAndPassword(email, password);
      _setLoading(false);
      return _userModel != null;
    } catch (e) {
      _setLoading(false);
      rethrow;
    }
  }

  Future<bool> register(String email, String password, String name, String hostel, String roomNo) async {
    _setLoading(true);
    try {
      _userModel = await _authService.signUpWithEmailAndPassword(email, password, name, hostel, roomNo);
      _setLoading(false);
      return _userModel != null;
    } catch (e) {
      _setLoading(false);
      rethrow;
    }
  }

  Future<void> logout() async {
    _setLoading(true);
    await _authService.signOut();
    _userModel = null;
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
