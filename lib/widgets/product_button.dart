import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/shopping_results.dart';

class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({required this.name, required this.price, required this.imageUrl});

  Product.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'].toDouble(),
        imageUrl = json['imageUrl'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'imageUrl': imageUrl,
      };
}

class ProductButton extends StatelessWidget {
  final Product product;
  final VoidCallback onPressed;

  const ProductButton(
      {super.key, required this.product, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        padding: EdgeInsets.zero,
        // Button text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                Provider.of<ShoppingState>(context, listen: false)
                    .addToCart(product);
              },
              child: const Text("Add to Cart"),
            )
          ],
        ),
      ),
    );
  }
}
