import 'package:example_shop_sudocodellc/providers/shopping_results.dart';
import 'package:example_shop_sudocodellc/screens/login_page.dart';
import 'package:example_shop_sudocodellc/widgets/shift_right_fixer.dart';
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
    String result =
        "Home with state: \"${Provider.of<ShoppingState>(context).state}\"";
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
    return ShiftRightFixer(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Your Shop!"),
          actions: [
            TextButton(
              style: style,
              onPressed: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
              child: const Text("Log In"),
            ),
            TextButton(
              style: style,
              onPressed: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
              child: const Text("Sign Up"),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Text(result),
              ElevatedButton(
                onPressed: () => {
                  Provider.of<ShoppingState>(context, listen: false).update()
                },
                child: const Text("Increment"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
