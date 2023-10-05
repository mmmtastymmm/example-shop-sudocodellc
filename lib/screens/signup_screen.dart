import 'package:example_shop_sudocodellc/screens/home_page.dart';
import 'package:example_shop_sudocodellc/widgets/shift_right_fixer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = "/signup";

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  String _issue = "";

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final emailAddress = _emailController.text;
    final password = _passwordController.text;
    final displayName = _displayNameController.text;
    String localIssue = "";
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(displayName);
      }
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        localIssue = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        localIssue = 'An account already exists for that email.';
      } else {
        localIssue = "Got a signup server error: $e";
      }
    } catch (e) {
      localIssue = "Got an unexpected error: $e";
    }
    setState(() {
      _issue = localIssue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShiftRightFixer(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Signup for Your Shop!"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _displayNameController,
                  decoration: const InputDecoration(labelText: 'Display Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a display name.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
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
                    ? const SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : Text(
                        _issue,
                        style: const TextStyle(color: Colors.red),
                      ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Signup'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
