import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:greenhub/core/shared/cache/shared_helper.dart';
import '../shared/blocs/main_app_bloc.dart';

/// Preferences related
const String _storageKey = 'MyApplication_';
const List<String> _supportedLanguages = ['en', 'ar', 'fr'];

class GlobalTranslations {
  Locale? _locale;
  Map<dynamic, dynamic>? _localizedValues;
  VoidCallback? _onLocaleChangedCallback;

  /// Returns the list of supported Locales
  Iterable<Locale> supportedLocales() =>
      _supportedLanguages.map<Locale>((lang) => Locale(lang));

  /// Returns the translation that corresponds to the [key]
  String text(String key) {
    return (_localizedValues == null || _localizedValues![key] == null)
        ? '** $key not found'
        : _localizedValues![key];
  }

  /// Returns the current language code
  String get currentLanguage => _locale?.languageCode ?? 'en';

  /// Returns the current Locale
  Locale? get locale => _locale;

  /// One-time initialization
  Future<void> init([String? language]) async {
    // Load preferred language if _locale is null
    if (_locale == null) {
      await setNewLanguage(language, false);
    }
  }

  /// Method that saves/restores the preferred language
  Future<String> getPreferredLanguage() async {
    return await _getApplicationSavedInformation('language') ??
        ''; // Empty string for first-time users
  }

  Future<void> setPreferredLanguage(String lang) async {
    await _setApplicationSavedInformation('language', lang);
  }

  /// Routine to change the language
  Future<void> setNewLanguage([
    String? newLanguage,
    bool saveInPrefs = true,
    BuildContext? context,
  ]) async {
    String language =
        newLanguage ??
        await getPreferredLanguage(); // Get preferred language if not set

    if (language.isEmpty) {
      language = 'en'; // Fallback to English if empty
    }

    _locale = Locale(language);
    String jsonContent = await rootBundle.loadString(
      'assets/langs/${_locale!.languageCode}.json',
    );
    _localizedValues = json.decode(jsonContent);

    // Always update the stream so MaterialApp rebuilds with correct directionality
    mainAppBloc.updateLang(language);

    // Only persist to storage if saveInPrefs is true
    if (saveInPrefs) {
      await setPreferredLanguage(language);
    }

    // If there's a callback, invoke it
    if (_onLocaleChangedCallback != null) {
      _onLocaleChangedCallback!();
    }
  }

  /// Callback to be invoked when the user changes the language
  set onLocaleChangedCallback(VoidCallback callback) {
    _onLocaleChangedCallback = callback;
  }

  /// Generic routine to fetch an application preference
  Future<String> _getApplicationSavedInformation(String name) async {
    return await SharedHelper.box!.get(_storageKey + name) ??
        ''; // Empty string for first-time users
  }

  /// Generic routine to save an application preference
  Future<void> _setApplicationSavedInformation(
    String name,
    String value,
  ) async {
    await SharedHelper.box!.put(_storageKey + name, value);
  }

  /// Singleton Factory
  static final GlobalTranslations _translations =
      GlobalTranslations._internal();

  factory GlobalTranslations() {
    return _translations;
  }

  GlobalTranslations._internal();
}

GlobalTranslations allTranslations = GlobalTranslations();
