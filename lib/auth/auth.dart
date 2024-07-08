import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pau_sosyal/auth/login_or_register.dart';
import 'package:pau_sosyal/navigation/app_router.dart';

@RoutePage()
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AutoRouter.of(context).replace(const TabRoute());
            return const SizedBox();
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
