import 'package:example_shop_sudocodellc/widgets/shift_right_fixer.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ShiftRightFixer(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Your Shop!"),
        ),
        body: const Center(
          child: Text("Login"),
        ),
      ),
    );
  }
}
