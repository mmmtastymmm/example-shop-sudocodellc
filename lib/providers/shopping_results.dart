import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ShoppingState extends ChangeNotifier {
  User? _currentUser;
  String firstName = "";
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ShoppingState() {
    _initializeListeners();
  }

  _initializeListeners() {
    _firebaseAuth.authStateChanges().listen((user) {
      _currentUser = user;
      updateUserRelatedValues();
      notifyListeners();
    });

    // Listener for user metadata changes
    _firebaseAuth.userChanges().listen((user) {
      if (user != null) {
        _currentUser = user; // Update the user with the latest data
        updateUserRelatedValues();
        notifyListeners();
      }
    });
  }

  updateUserRelatedValues() {
    if (_currentUser != null && _currentUser?.displayName != null) {
      List<String> values = _currentUser?.displayName!.split(" ") ?? [""];
      firstName = values[0];
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  User? get currentUser => _currentUser;

// Additional methods for sign in, sign out, etc. can also be added here
}
