import 'package:boba_tea_app/pages/home_page.dart';
import 'package:boba_tea_app/pages/login_or_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // user is logged in
          return HomePage();
        } else {
          // user is not logged in
          return const LoginOrRegisterPage();
        }
      },
    ));
  }
}
