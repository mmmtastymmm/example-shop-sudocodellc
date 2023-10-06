import 'package:example_shop_sudocodellc/widgets/shift_right_fixer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _issue = "";

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final emailAddress = _emailController.text;
    final password = _passwordController.text;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      String localIssue = "";
      if (e.code == 'user-not-found') {
        localIssue = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        localIssue = 'Wrong password provided for that user.';
      } else if (e.code == "invalid-login-credentials") {
        localIssue = "Invalid login provided";
      } else {
        localIssue = "Error: ${e.message}";
      }
      setState(() {
        _issue = localIssue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShiftRightFixer(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Your Shop!"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Password must be at least 6 characters long.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _issue.isEmpty
                    ? const SizedBox.shrink()
                    : Text(
                        _issue,
                        style: const TextStyle(color: Colors.red),
                      ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
