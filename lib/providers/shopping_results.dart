import 'package:flutter/cupertino.dart';

class ShoppingState with ChangeNotifier {
  String state = "0";
  int count = 0;

  void update() {
    count += 1;
    state = count.toString();
    notifyListeners();
  }
}
