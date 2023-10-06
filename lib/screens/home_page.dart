import 'package:example_shop_sudocodellc/providers/shopping_results.dart';
import 'package:example_shop_sudocodellc/screens/login_page.dart';
import 'package:example_shop_sudocodellc/screens/signup_screen.dart';
import 'package:example_shop_sudocodellc/screens/user_page.dart';
import 'package:example_shop_sudocodellc/widgets/shift_right_fixer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item_widget.dart';
import '../widgets/product_button.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. Sample list of products
  List<Product> sampleProducts = [
    Product(
        name: 'Product 1',
        price: 19.99,
        imageUrl:
            'https://images.unsplash.com/photo-1572635196237-14b3f281503f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80'),
    Product(
        name: 'Product 2',
        price: 29.99,
        imageUrl:
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'),
    Product(
        name: 'Product 1',
        price: 19.99,
        imageUrl:
            'https://images.unsplash.com/photo-1572635196237-14b3f281503f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80'),
    Product(
        name: 'Product 2',
        price: 29.99,
        imageUrl:
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'),
    Product(
        name: 'Product 1',
        price: 19.99,
        imageUrl:
            'https://images.unsplash.com/photo-1572635196237-14b3f281503f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80'),
    Product(
        name: 'Product 2',
        price: 29.99,
        imageUrl:
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80'),

    // ... Add more sample products as needed
  ];

  void _showCheckoutAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Checkout Alert'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          // to make the column wrap its children
          children: [
            Icon(
              Icons.sentiment_dissatisfied,
              size: 60, // Adjust the size as needed
              color: Colors.red, // Adjust the color as needed
            ),
            SizedBox(height: 20),
            Text('This is just a demo so you can\'t actually buy these.'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    List<Product> cartItems = Provider.of<ShoppingState>(context).cartItems;

    return SizedBox(
      height: 400,
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            alignment: Alignment.center,
            child: const Text(
              'Your Cart',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${cartItems.length} Items',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '\$${Provider.of<ShoppingState>(context).totalCartValue.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.green, fontSize: 16),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (ctx, index) =>
                  CartItemWidget(product: cartItems[index]),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: cartItems.isEmpty
                ? const SizedBox()
                : ElevatedButton(
                    onPressed: () {
                      _showCheckoutAlert(context);
                    },
                    child: const Text("Checkout"),
                  ),
          ),
        ],
      ),
    );
  }

  String _getNameFromUser(User? user) {
    if (user != null && user.displayName != null) {
      List<String> values = user.displayName!.split(" ");
      return "${values[0]} ";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle signUpStyle = ElevatedButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context)
          .colorScheme
          .onPrimary, // text color for the sign-up button
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // round the button edges
      ),
    );
    String result =
        "Home with state: \"${Provider.of<ShoppingState>(context).currentUser}\"";
    String greeting =
        "Welcome ${_getNameFromUser(Provider.of<ShoppingState>(context).currentUser)}to the shop demo!";
    User? currentUser = Provider.of<ShoppingState>(context).currentUser;
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
    return ShiftRightFixer(
      child: Scaffold(
        appBar: AppBar(
          title: Text(greeting),
          actions: [
            currentUser == null
                ? TextButton(
                    style: style,
                    onPressed: () {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                    child: const Text("Log In"),
                  )
                : TextButton(
                    style: style,
                    onPressed: () => Navigator.of(context)
                        .pushNamed(UserProfileScreen.routeName),
                    child: const Text("User Profile"),
                  ),
            currentUser == null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: signUpStyle,
                      onPressed: () {
                        Navigator.of(context).pushNamed(SignupScreen.routeName);
                      },
                      child: const Text("Sign Up"),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        body: Column(
          children: [
            Text(result),
            ElevatedButton(
              onPressed: () => {print("Button pushed")},
              child: const Text("Increment"),
            ),
            // 2. Replace the Center widget with the GridView.builder
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  int crossAxisCount = constraints.maxWidth ~/
                      200; // Assuming each item is roughly 150 logical pixels wide
                  if (crossAxisCount < 1) {
                    crossAxisCount =
                        1; // Safety check, at least one item will be displayed
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: sampleProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (ctx, index) => Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ProductButton(
                        product: sampleProducts[index],
                        onPressed: () {
                          print('Product ${sampleProducts[index].name} tapped');
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => _buildBottomSheet(context),
            );
          },
          tooltip: 'Shopping Cart',
          child: Stack(
            children: <Widget>[
              const Icon(Icons.shopping_cart),
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Text(
                    Provider.of<ShoppingState>(context)
                        .cartItems
                        .length
                        .toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
