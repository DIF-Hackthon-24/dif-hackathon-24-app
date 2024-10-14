import 'dart:async';
import 'dart:convert';
import 'package:core/utils/extensions/object_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprintf/sprintf.dart';

List<String>? data = [];

class AppLocalizations {
  final Locale locale;
  static Map<String, String> packages = {};
  static List<String> localeList = [];
  static const String mainPackage = 'mainPackage';

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax

  static LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate(localeList);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  final _localizedStrings = <String, Map<String, dynamic>>{};

  Future parsePackage({required String shortName, required String packageName}) async {
    final path = 'packages/$packageName/assets/lang/${locale.languageCode}.json';
    _createLocalizedStrings(shortName, path);
  }

  Future parseMainPackage({required String shortName}) async {
    final path = 'assets/lang/${locale.languageCode}.json';
    _createLocalizedStrings(shortName, path);
  }

  void _createLocalizedStrings(String shortName, String path) async {
    final jsonString = await rootBundle.loadString(path);
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    final mapEntry = jsonMap.map((key, value) {
      return MapEntry(key, value);
    });
    _localizedStrings[shortName] = mapEntry;
  }

  Future<bool> load() async {
    await Future.forEach(packages.keys, (String key) async {
      await parsePackage(shortName: key, packageName: packages[key].toString());
    });
    await parseMainPackage(shortName: mainPackage);
    return true;
  }

  String translate(String key, {List<dynamic> args = const []}) {
    final splitStrings = key.split(':');

    var message = key;
    late String packageName;
    late String stringKey;
    if (splitStrings.length > 1) {
      packageName = splitStrings.first;
      stringKey = splitStrings.last;
    } else if (splitStrings.length == 1) {
      stringKey = splitStrings.first;
      packageName = mainPackage;
    }
    final stringsList = _localizedStrings[packageName];
    message = stringsList?[stringKey] ?? key;
    if (args.isEmpty) {
      return message;
    } else {
      return sprintf(message, args);
    }
  }

  Map<String,dynamic>? translateMap(String key) {
    final splitStrings = key.split(':');

    late String packageName;
    late String dynamicKey;
    if (splitStrings.length > 1) {
      packageName = splitStrings.first;
      dynamicKey = splitStrings.last;
    } else if (splitStrings.length == 1) {
      dynamicKey = splitStrings.first;
      packageName = mainPackage;
    }
    if(_localizedStrings.isNotEmptyOrNull){
      final mapList = _localizedStrings[packageName]??{};
      return mapList[dynamicKey] ?? {};
    }
    return {};
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  List<String> localeList;
  _AppLocalizationsDelegate(this.localeList);

  @override
  bool isSupported(Locale locale) {
    return localeList.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
