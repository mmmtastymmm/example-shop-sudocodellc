import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/shopping_results.dart';

class UserProfileScreen extends StatelessWidget {
  static const routeName = "/user-profile";

  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? currentUser = Provider.of<ShoppingState>(context).currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: currentUser == null
            ? const Text(
                "User not logged in",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Display user's email
                  if (currentUser.email != null)
                    Text(
                      "Email: ${currentUser.email}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  const SizedBox(height: 20), // Spacer
                  // Display user's display name
                  if (currentUser.displayName != null)
                    Text(
                      "Display Name: ${currentUser.displayName}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                  const SizedBox(height: 20), // Spacer

                  // Display user's account creation date
                  if (currentUser.metadata.creationTime != null)
                    Text(
                      "Account Created: ${currentUser.metadata.creationTime}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                  const SizedBox(height: 40), // Spacer
                  ElevatedButton(
                    onPressed: currentUser.emailVerified
                        ? null
                        : () async {
                            await Provider.of<ShoppingState>(context,
                                    listen: false)
                                .sendEmailVerification();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Verification email sent!'),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentUser.emailVerified
                          ? Colors.grey
                          : null, // sets the background color to grey when the button is disabled
                    ),
                    child: currentUser.emailVerified
                        ? const Text("Email Verified")
                        : const Text("Send Verification Email"),
                  ),
                  const SizedBox(height: 20), // Spacer
                  ElevatedButton(
                    onPressed: () async {
                      await Provider.of<ShoppingState>(context, listen: false)
                          .signOut();
                      Provider.of<ShoppingState>(context, listen: false)
                          .clearCartForSignOut();
                      // Navigate to /home and clear all routes beneath it
                      Navigator.of(context).pop();
                    },
                    child: const Text("Logout"),
                  ),
                ],
              ),
      ),
    );
  }
}
