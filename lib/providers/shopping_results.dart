import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ShoppingState extends ChangeNotifier {
  User? _currentUser;
  String firstName = "";
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ShoppingState() {
    _firebaseAuth.authStateChanges().listen((user) {
      _currentUser = user;
      _updateUserRelatedValues();
      notifyListeners();
    });
  }

  _updateUserRelatedValues() {
    if (_currentUser != null && _currentUser?.displayName != null) {
      List<String> values = _currentUser?.displayName!.split(" ") ?? [""];
      firstName = values[0];
    }
  }

  User? get currentUser => _currentUser;

// Additional methods for sign in, sign out, etc. can also be added here
}
