import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(String userId, String username, String email) {
    return _db.collection('users').doc(userId).set({
      'username': username,
      'email': email,
    });
  }
}
