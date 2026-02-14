// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Глобальные события диаспоры';

  @override
  String get loginTitle => 'С возвращением';

  @override
  String get loginSubtitle => 'Общайтесь со своим сообществом по всему миру';

  @override
  String get emailLabel => 'Электронная почта';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get loginButton => 'Войти';

  @override
  String get signUpButton => 'Создать аккаунт';

  @override
  String get googleSignIn => 'Войти через Google';

  @override
  String get appleSignIn => 'Войти через Apple';

  @override
  String get eventsFeedTitle => 'Обзор';

  @override
  String get noEventsFound => 'Событий не найдено';

  @override
  String get profileTitle => 'Мой профиль';

  @override
  String get interestsTitle => 'Интересы';
}
