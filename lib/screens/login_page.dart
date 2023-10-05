import 'package:example_shop_sudocodellc/widgets/shift_right_fixer.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
