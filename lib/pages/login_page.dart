import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pau_sosyal/components/my_button.dart';
import 'package:pau_sosyal/components/my_textfield.dart';
import 'package:pau_sosyal/helper/helper_function.dart';
import 'package:pau_sosyal/language/locale_keys.g.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailConroller = TextEditingController();

  final TextEditingController passwordConroller = TextEditingController();

  void login() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailConroller.text, password: passwordConroller.text);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                        image: AssetImage('assets/icons/ic_login.png')),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  LocaleKeys.login_title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ).tr(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  LocaleKeys.login_subtitle,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ).tr(),
                const SizedBox(
                  height: 50,
                ),
                MyTextField(
                  hintText: LocaleKeys.login_email,
                  obscureText: false,
                  controller: emailConroller,
                  suffixIcon: const SizedBox.shrink(),
                  prefixIcon: Image.asset(
                    "assets/icons/ic_envelope.png",
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  hintText: LocaleKeys.login_password,
                  obscureText: showPassword,
                  controller: passwordConroller,
                  suffixIcon: IconButton(
                    icon: Image.asset(
                      "assets/icons/ic_eye.png",
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                  prefixIcon: Image.asset(
                    "assets/icons/ic_lock.png",
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                  textColor: Colors.white,
                  color: const Color(0xff2952E4),
                  text: LocaleKeys.login_title,
                  onTap: login,
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.login_account,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ).tr(),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        LocaleKeys.login_register,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ).tr(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
