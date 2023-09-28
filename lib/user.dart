import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  // Method to get the userid asynchronously
  Future<String> callUserId() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('Users').get();
      final users = snapshot.docs.where((doc) {
        return doc.id != FirebaseAuth.instance.currentUser?.uid;
      });

      if (users.isNotEmpty) {
        final user = users.first;
        return user.id; // Return userid as a String
      }
    } catch (e) {
      print('Error retrieving userid: $e');
    }
    return ''; // Return an empty string if no userid is found or an error occurs
  }
}
