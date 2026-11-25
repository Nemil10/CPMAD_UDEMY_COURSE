import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class FirebaseService {
  static final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  /// Stream of users for real-time Cloud Firestore updates
  static Stream<List<UserModel>> getUsersStream() {
    return _usersCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }

  /// Add a new user to Cloud Firestore
  static Future<void> addUser(UserModel user) async {
    await _usersCollection.add(user.toMap());
  }

  /// Update an existing user in Cloud Firestore
  static Future<void> updateUser(UserModel user) async {
    if (user.id == null) return;
    await _usersCollection.doc(user.id).update(user.toMap());
  }

  /// Delete a user by document ID from Cloud Firestore
  static Future<void> deleteUser(String id) async {
    await _usersCollection.doc(id).delete();
  }
}
