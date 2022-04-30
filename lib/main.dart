import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Screen/auth/login_screen.dart';
import 'package:news_app/Screen/main_screen.dart';

import 'Screen/auth/create_caaount_screen.dart';
import 'Screen/auth/forget_password_screen.dart';
import 'Screen/launch_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => const LaunchScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/forgetPassword_screen': (context) => const ForgetPasswordScreen(),
        '/create_account_screen': (context) => const CreateAccountScreen(),
        '/main_screen': (context) => const MainScreen(),
      },
    );
  }
}
