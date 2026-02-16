// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Global Diaspora Events';

  @override
  String get login => 'Увійти';

  @override
  String get register => 'Реєстрація';

  @override
  String get email => 'Email';

  @override
  String get password => 'Пароль';

  @override
  String get forgotPassword => 'Забули пароль?';

  @override
  String get createAccount => 'Створити акаунт';

  @override
  String get alreadyHaveAccount => 'Вже є акаунт?';

  @override
  String get dontHaveAccount => 'Немає акаунту?';

  @override
  String get eventsNearYou => 'Події поблизу';

  @override
  String get mapView => 'Карта';

  @override
  String get listView => 'Список';

  @override
  String get saved => 'Збережені';

  @override
  String get profile => 'Профіль';

  @override
  String get settings => 'Налаштування';

  @override
  String get logout => 'Вийти';

  @override
  String get imGoing => 'Я йду';

  @override
  String peopleGoing(int count) {
    return '$count йдуть';
  }
}
