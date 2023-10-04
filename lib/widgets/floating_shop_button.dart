import 'package:example_shop_sudocodellc/widgets/product_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/shopping_results.dart';
import 'cart_item_widget.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${cartItems.length} Items',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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

FloatingActionButton makeShopButton(BuildContext context) {
  return FloatingActionButton(
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
              Provider.of<ShoppingState>(context).cartItems.length.toString(),
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
  );
}
