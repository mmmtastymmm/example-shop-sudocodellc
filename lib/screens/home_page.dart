import 'package:example_shop_sudocodellc/providers/shopping_results.dart';
import 'package:example_shop_sudocodellc/screens/login_page.dart';
import 'package:example_shop_sudocodellc/screens/signup_screen.dart';
import 'package:example_shop_sudocodellc/widgets/shift_right_fixer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
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
        "Welcome ${Provider.of<ShoppingState>(context).firstName} to the shop demo!";
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
                : const SizedBox(),
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
        body: Center(
          child: Column(
            children: [
              Text(result),
              ElevatedButton(
                onPressed: () => {print("Button pushed")},
                child: const Text("Increment"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
