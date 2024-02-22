import 'package:flutter/material.dart';
import 'package:flutteremailpasse/login_register.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is connected
          if (snapshot.hasData) {
            return HomePage();
          } else // User not connected
          {
            return LoginRegister();
          }
        },
      ), // StreamBuilder
    );
  }
}
