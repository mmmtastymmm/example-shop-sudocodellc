import 'package:example_shop_sudocodellc/providers/shopping_results.dart';
import 'package:example_shop_sudocodellc/screens/home_page.dart';
import 'package:example_shop_sudocodellc/screens/login_page.dart';
import 'package:example_shop_sudocodellc/widgets/shift_right_fixer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // This makes providers that the others can query
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => ShoppingState()),
      ],
      child: MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
          fontFamily: "Lato",
          // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
          //     .copyWith(secondary: Colors.black),
        ),
        home: const ShiftRightFixer(child: HomeScreen()),
        routes: {
          LoginScreen.routeName: (context) {
            return const LoginScreen();
          },
          HomeScreen.routeName: (context) {
            return const HomeScreen();
          },
        },
      ),
    );
  }
}
