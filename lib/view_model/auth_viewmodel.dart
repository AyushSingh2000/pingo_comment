import 'package:flutter/material.dart';

import '../services/firebase_auth_service.dart';
import '../services/firestore_service.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> login(String email, String password) async {
    await _authService.signIn(email, password);
    // Handle post-login logic
  }

  Future<void> signUp(String username, String email, String password) async {
    var user = await _authService.signUp(email, password);
    if (user != null) {
      await _firestoreService.createUser(user.uid, username, email);
    }
    // Handle post-signup logic
  }
}
