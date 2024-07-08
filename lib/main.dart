import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pau_sosyal/api/firebase_api.dart';
import 'package:pau_sosyal/firebase_options.dart';
import 'package:pau_sosyal/navigation/app_router.dart';
import 'package:pau_sosyal/provider/provider.dart';
import 'package:provider/provider.dart';

import 'language/language_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableLevels = [LevelMessages.error];
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await FirebaseApi().initNotifications();
  runApp(LanguageManager(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });
  static final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UiProvider()..init(),
      child: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: notifier.isDark ? notifier.darkTheme : notifier.lightTheme,
            routerConfig: _appRouter.config(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          );
        },
      ),
    );
  }
}
