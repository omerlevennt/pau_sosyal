import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pau_sosyal/language/locale_keys.g.dart';
import 'package:pau_sosyal/navigation/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

@override
class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    goToNextPage();
  }

  Future<void> goToNextPage() async {
    //final router = context.router;
    await Future<void>.delayed(const Duration(seconds: 3));
    await _checkIntroductionSeen();
  }

  Future<void> _checkIntroductionSeen() async {
    final prefs = await SharedPreferences.getInstance();
    final router = context.router;
    final hasSeenIntroduction = prefs.getBool('hasSeenIntroduction') ?? false;
    if (hasSeenIntroduction) {
      await router.replace(const AuthRoute());
    } else {
      await router.replace(const OnBoardRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                  image: AssetImage('assets/icons/ic_app.png')),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            LocaleKeys.App_name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
          ).tr(),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
