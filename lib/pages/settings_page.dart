import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pau_sosyal/components/my_button.dart';
import 'package:pau_sosyal/enum/locales.dart';
import 'package:pau_sosyal/language/locale_keys.g.dart';
import 'package:pau_sosyal/navigation/app_router.dart';
import 'package:pau_sosyal/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  bool _allowNotifications = true;
  Locales _selectedLanguage = Locales.tr;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await _loadNotificationPreference();
    await _checkNotificationPermissions();
    await _loadLanguagePreference();
  }

  Future<void> _checkNotificationPermissions() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.getNotificationSettings();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('Bildirimler için izin verilmiş');
      }
    } else {
      if (kDebugMode) {
        print('Bildirimler için izin istenmeli');
      }
    }
  }

  Future<void> _saveNotificationPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('bildirim_tercihi', value);
  }

  Future<void> _loadNotificationPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _allowNotifications = prefs.getBool('bildirim_tercihi') ?? true;
    });
  }

  void _onSwitchValueChanged(bool value) async {
    setState(() {
      _allowNotifications = value;
    });
    if (!_allowNotifications) {
      await FirebaseMessaging.instance.unsubscribeFromTopic('all');
    } else {
      await FirebaseMessaging.instance.subscribeToTopic('all');
    }
    await _saveNotificationPreference(value);
  }

  Future<void> _saveLanguagePreference(Locales value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', value.toString());
  }

  Future<void> _loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('selected_language');
    if (languageCode != null) {
      _selectedLanguage = Locales.values
          .firstWhere((locale) => locale.toString() == languageCode);
      context.setLocale(_selectedLanguage.locale);
    }
  }

  void _onLanguageChanged(Locales newValue) {
    setState(() {
      _selectedLanguage = newValue;
    });
    context.setLocale(newValue.locale);
    _saveLanguagePreference(newValue);
  }

  @override
  Widget build(BuildContext context) {
    List<String> diller = ['Türkçe', 'İngilizce'];

    return Scaffold(
      body:
          Consumer<UiProvider>(builder: (context, UiProvider notifier, child) {
        return FutureBuilder(
            future: getUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else if (snapshot.hasData) {
                Map<String, dynamic>? user = snapshot.data!.data();
                String text = user!['userName'];
                String fisrtWord = text.substring(0, 1);
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 1.5,
                              ),
                            ),
                            width: 120,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundColor: Colors.grey.shade200,
                              child: user['image'] != null
                                  ? CircleAvatar(
                                      radius: 60.0,
                                      backgroundImage:
                                          NetworkImage(user['image']),
                                    )
                                  : Text(
                                      fisrtWord,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                    ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          user['userName'],
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user['email'],
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 1.5,
                            ),
                          ),
                          child: ListTile(
                            title: const Text(LocaleKeys.settings_notification)
                                .tr(),
                            trailing: Switch(
                              value: _allowNotifications,
                              onChanged: _onSwitchValueChanged,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 1.5,
                            ),
                          ),
                          child: ListTile(
                            title:
                                const Text(LocaleKeys.settings_darkMode).tr(),
                            trailing: Switch(
                              value: notifier.isDark,
                              onChanged: (value) => notifier.changeTheme(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 1.5,
                            ),
                          ),
                          child: ListTile(
                            title:
                                const Text(LocaleKeys.settings_language).tr(),
                            trailing: DropdownButton<Locales>(
                              value: _selectedLanguage,
                              items: diller
                                  .map((dil) => DropdownMenuItem<Locales>(
                                        value: dil == 'Türkçe'
                                            ? Locales.tr
                                            : Locales.en,
                                        child: Text(dil),
                                      ))
                                  .toList(),
                              onChanged: (selectedLanguage) {
                                _onLanguageChanged(selectedLanguage!);
                              },
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 1.5,
                            ),
                          ),
                          child: MyButton(
                            textColor: Theme.of(context).colorScheme.primary,
                            color: Colors.transparent,
                            text: LocaleKeys.settings_logOut,
                            onTap: () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.remove('hasSeenIntroduction');
                              FirebaseAuth.instance.signOut();
                              context.router.replace(const AuthRoute());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            });
      }),
    );
  }
}
