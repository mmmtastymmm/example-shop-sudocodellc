import 'package:example_shop_sudocodellc/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/shopping_results.dart';

class UserProfileScreen extends StatelessWidget {
  static const routeName = "/user-profile";

  @override
  Widget build(BuildContext context) {
    User? currentUser = Provider.of<ShoppingState>(context).currentUser;
    String firstName = Provider.of<ShoppingState>(context).firstName;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ... [rest of your user details widgets]

            ElevatedButton(
              onPressed: () async {
                await Provider.of<ShoppingState>(context, listen: false)
                    .signOut();

                // Navigate to /home and clear all routes beneath it
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
