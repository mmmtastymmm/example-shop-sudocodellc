import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../widgets/product_button.dart';

class ShoppingState extends ChangeNotifier {
  User? _currentUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  List<Product> _cartItems = []; // List to hold cart items

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
        _currentUser = user;
        notifyListeners();
      }
    });
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }

  Future<void> sendEmailVerification() async {
    if (_currentUser != null && !_currentUser!.emailVerified) {
      await _currentUser!.sendEmailVerification();
    }
  }

  // Cart management methods

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  double get totalCartValue {
    return cartItems.fold(
        0, (previousValue, product) => previousValue + product.price);
  }

  List<Product> get cartItems => _cartItems;

  User? get currentUser => _currentUser;
}
