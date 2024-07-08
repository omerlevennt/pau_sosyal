import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pau_sosyal/enum/locales.dart';

final class LanguageManager extends EasyLocalization {
  LanguageManager({
    required super.child,
    super.key,
  }) : super(
          supportedLocales: _supportedLocalesItems,
          path: _translationPath,
          useOnlyLangCode: true,
        );

  static final List<Locale> _supportedLocalesItems = [
    Locales.tr.locale,
    Locales.en.locale,
  ];

  static const String _translationPath = 'assets/translations';

  void changeLanguage({
    required BuildContext context,
    required Locales value,
  }) =>
      context.setLocale(value.locale);
}
