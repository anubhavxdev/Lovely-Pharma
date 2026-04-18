import 'package:lovely_pharma/models/user_model.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  // Temporary mocks
  UserModel? _mockUser;
  
  // Stream of auth state changes (Mocked to always be null initially)
  Stream<UserModel?> get authStateChanges => Stream.value(_mockUser);

  // Get current user UID
  String? get currentUid => _mockUser?.uid;

  // Sign up
  Future<UserModel?> signUpWithEmailAndPassword(
      String email, String password, String name, String hostel, String roomNo) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network
    
    _mockUser = UserModel(
      uid: const Uuid().v4(),
      name: name.trim(),
      email: email.trim(),
      hostel: hostel.trim(),
      roomNo: roomNo.trim(),
    );
    return _mockUser;
  }

  // Log in
  Future<UserModel?> loginWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network
    
    _mockUser = UserModel(
      uid: const Uuid().v4(),
      name: 'Test UI User',
      email: email.trim(),
      hostel: 'Hostel A',
      roomNo: '101',
    );
    return _mockUser;
  }

  // Get user details from Firestore
  Future<UserModel?> getUserDetails(String uid) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockUser;
  }

  // Sign out
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockUser = null;
  }
}
