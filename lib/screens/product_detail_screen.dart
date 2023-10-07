import 'package:flutter/material.dart';

import '../widgets/product_button.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail'; // For navigation purposes

  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        // Ensures the screen is scrollable if the content overflows
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300, // You can adjust this based on your preference
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                product.description,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.5, // Adjusts line height for better readability
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
