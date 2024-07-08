import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import Image Picker
import 'package:pau_sosyal/components/my_button.dart';
import 'package:pau_sosyal/components/my_textfield.dart';
import 'package:pau_sosyal/language/locale_keys.g.dart';

import '../helper/helper_function.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController userNameConroller = TextEditingController();
  final TextEditingController emailConroller = TextEditingController();
  final TextEditingController passwordConroller = TextEditingController();
  final TextEditingController confirmPwConroller = TextEditingController();

  XFile? pickedImage; // Variable to store the selected image

  void registerUser() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    if (passwordConroller.text != confirmPwConroller.text) {
      Navigator.pop(context);
      displayMessageToUser("Şifre eşleşmiyor", context);
    } else {
      try {
        // Create User with Email and Password
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailConroller.text, password: passwordConroller.text);

        // Upload profile picture if selected (handle potential errors)
        String imageUrl = "";
        if (pickedImage != null) {
          try {
            imageUrl = await uploadProfilePicture(pickedImage!.path);
          } catch (error) {
            Navigator.pop(context);
            displayMessageToUser(
                "Profil resmi yüklenirken hata oluştu: $error", context);
            return; // Exit the function on error
          }
        }

        // Create User Document in Firestore (handle potential errors)
        try {
          await createUserDocument(userCredential, imageUrl);
          Navigator.pop(context); // Close progress dialog on success
        } catch (error) {
          Navigator.pop(context);
          displayMessageToUser(
              "Kullanıcı belgesi oluşturulurken hata oluştu: $error", context);
          return; // Exit the function on error
        }
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
      }
    }
  }

  // Corrected uploadProfilePicture function
  Future<String> uploadProfilePicture(String filePath) async {
    // Check if pickedImage is null
    if (pickedImage == null) {
      return ""; // Return empty string if no image selected
    }

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final storageRef =
        FirebaseStorage.instance.ref().child('profile_pictures/$fileName');
    await storageRef.putFile(File(filePath));
    final downloadUrl = await storageRef.getDownloadURL();
    return downloadUrl;
  }

  Future<void> createUserDocument(
      UserCredential? userCredential, String imageUrl) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'userName': userNameConroller.text,
        'imageUrl': imageUrl, // Add imageUrl field
      });
    }
  }

  bool showPassword = true;
  bool confirmShowPassword = true;

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
                  height: 50,
                ),
                GestureDetector(
                  onTap: () async {
                    final imagePicker = ImagePicker();
                    pickedImage = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    setState(() {});
                  },
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage: pickedImage != null
                        ? FileImage(File(pickedImage!.path)) as ImageProvider
                        : const AssetImage(
                            'assets/icons/ic_user.png'), // Default image placeholder
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MyTextField(
                  hintText: LocaleKeys.register_nameSurname,
                  obscureText: false,
                  controller: userNameConroller,
                  suffixIcon: const SizedBox.shrink(),
                  prefixIcon: Image.asset(
                    "assets/icons/ic_user.png",
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  hintText: LocaleKeys.register_email,
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
                  hintText: LocaleKeys.register_password,
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
                  height: 10,
                ),
                MyTextField(
                  hintText: LocaleKeys.register_passwordConfirm,
                  obscureText: confirmShowPassword,
                  controller: confirmPwConroller,
                  suffixIcon: IconButton(
                    icon: Image.asset(
                      "assets/icons/ic_eye.png",
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      setState(() {
                        confirmShowPassword = !confirmShowPassword;
                      });
                    },
                  ),
                  prefixIcon: Image.asset(
                    "assets/icons/ic_lock.png",
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                MyButton(
                  textColor: Colors.white,
                  color: const Color(0xff2952E4),
                  text: LocaleKeys.register_register,
                  onTap: registerUser,
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.register_account,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ).tr(),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        LocaleKeys.register_login,
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
