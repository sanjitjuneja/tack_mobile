import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:navigation/navigation.dart';

import '../di/app_di.dart';

class AppLocalizations {
  final Locale locale;
  static AppRouter? appRouter;

  AppLocalizations(
    this.locale,
  );

  static const String englishCode = 'en';
  static const Locale supportedEnglishLocale = Locale(englishCode, '');
  static const List<String> supportedLanguageCodes = <String>[englishCode];
  static const List<Locale> supportedLocales = <Locale>[supportedEnglishLocale];

  static const AppLocalizationsDelegate delegate = AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static Locale resolveLocale(
    Locale deviceLocale,
    Iterable<Locale> supportedLocales,
  ) {
    return supportedEnglishLocale;
  }

  static final Map<String, Map<String, String>> _localizedValues =
      <String, Map<String, String>>{
    englishCode: <String, String>{
      // Common
      'app.name': 'TackApp',

      // Dashboard
      'dashboard.greetings': 'Hello',
      'dashboard.title': 'Find your next tack',
      'dashboard.list.reviews': 'Reviews',
      'dashboard.list.ago': 'ago',

      // Create Tack
      'createTack.title': 'Create Tack',
      'createTack.description':
          'Select one of the following templates or create a Tack from scratch',

      // Buttons
      'button.accept': 'Accept',
      'button.remove': 'Remove',
      'button.editAndPublish': 'Edit & Publish',

      // Search Field
      'searchField.dashboard': 'Search Tacks, Users, Groups',
      'searchField.createTack': 'Search Templates',

      // Toggle
      'toggle.public': 'Public',
      'toggle.privat': 'Privat',
      'toggle.popular': 'Popular',
      'toggle.saved': 'Saved',
    }
  };

  String value(String key) {
    final Map<String, String>? language = _localizedValues[locale.languageCode];
    final String? languageKey = language?[key];
    if (language != null) {
      if (languageKey != null) {
        return languageKey;
      } else {
        return '${locale.languageCode} $key undefined';
      }
    } else {
      return '${locale.languageCode} undefined';
    }
  }

  static String ofGlobalContext(String key) {
    appRouter ??= appLocator.get<AppRouter>();
    final BuildContext context = appRouter!.navigatorKey.currentContext!;
    return AppLocalizations.of(context).value(key);
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLanguageCodes
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
