import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ShoppingState extends ChangeNotifier {
  User? _currentUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ShoppingState() {
    _initializeListeners();
  }

  _initializeListeners() {
    _firebaseAuth.authStateChanges().listen((user) {
      _currentUser = user;
      notifyListeners();
    });

    // Listener for user metadata changes
    _firebaseAuth.userChanges().listen((user) {
      if (user != null) {
        _currentUser = user; // Update the user with the latest data
        notifyListeners();
      }
    });
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }

  // Inside the ShoppingState class

  Future<void> sendEmailVerification() async {
    if (_currentUser != null && !_currentUser!.emailVerified) {
      await _currentUser!.sendEmailVerification();
    }
  }

  User? get currentUser => _currentUser;
}
