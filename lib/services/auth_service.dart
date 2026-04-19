import 'package:lovely_pharma/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream of auth state changes
  Stream<UserModel?> get authStateChanges {
    return _auth.authStateChanges().asyncMap((User? user) async {
      if (user == null) return null;
      return await getUserDetails(user.uid);
    });
  }

  // Get current user UID
  String? get currentUid => _auth.currentUser?.uid;

  // Sign up
  Future<UserModel?> signUpWithEmailAndPassword(
      String email, String password, String name, String hostel, String roomNo) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(), 
        password: password
      );

      if (cred.user != null) {
        UserModel newUser = UserModel(
          uid: cred.user!.uid,
          name: name.trim(),
          email: email.trim(),
          addresses: [{'hostel': hostel.trim(), 'roomNo': roomNo.trim()}],
        );

        await _firestore.collection('users').doc(newUser.uid).set(newUser.toMap());
        return newUser;
      }
    } catch (e) {
      print('Sign up error: $e');
      rethrow;
    }
    return null;
  }

  // Log in
  Future<UserModel?> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email.trim(), 
        password: password
      );
      
      if (cred.user != null) {
        return await getUserDetails(cred.user!.uid);
      }
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
    return null;
  }

  // Get user details from Firestore
  Future<UserModel?> getUserDetails(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
    } catch (e) {
      print('Get user details error: $e');
    }
    return null;
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
