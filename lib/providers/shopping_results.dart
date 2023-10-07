import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../widgets/product_button.dart';

class ShoppingState extends ChangeNotifier {
  User? _currentUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final List<Product> _cartItems = []; // List to hold cart items

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
    saveCartItemsToFirestore();
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    saveCartItemsToFirestore();
    notifyListeners();
  }

  void clearCartForSignOut() {
    _cartItems.clear();
    saveCartItemsToFirestore();
    notifyListeners();
  }

  double get totalCartValue {
    return cartItems.fold(
        0, (previousValue, product) => previousValue + product.price);
  }

  List<Product> get cartItems => _cartItems;

  User? get currentUser => _currentUser;

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> saveCartItemsToFirestore() async {
    try {
      if (_currentUser != null) {
        final userDocRef = usersCollection.doc(_currentUser!.uid);
        await userDocRef.set({
          'cartItems': _cartItems.map((product) => product.toJson()).toList(),
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchCartItemsFromFirestore() async {
    try {
      if (_currentUser != null) {
        final userDocRef = usersCollection.doc(_currentUser!.uid);
        final doc = await userDocRef.get();
        if (doc.exists) {
          final Map<String, dynamic>? data =
              doc.data() as Map<String, dynamic>?;
          final List<dynamic> cartItemsFromDb = data?['cartItems'] ?? [];
          _cartItems.addAll(
              cartItemsFromDb.map((item) => Product.fromJson(item)).toList());
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
