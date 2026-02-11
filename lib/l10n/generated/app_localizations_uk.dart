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
  String get welcomeTitle => 'Ласкаво просимо до\nGlobal Diaspora Events';

  @override
  String get welcomeSubtitle =>
      'Знайди своїх людей.\nЗнайди свої події.\nЗалишайся на зв\'язку зі своєю культурою.';

  @override
  String get whereAreYouFrom => 'Звідки ви?';

  @override
  String get countryHint => 'Це допоможе нам знайти події вашої культури';

  @override
  String get whatAreYouInto => 'Чим цікавитесь?';

  @override
  String get interestsHint =>
      'Оберіть принаймні одне для персоналізації стрічки';

  @override
  String get next => 'Далі';

  @override
  String get back => 'Назад';

  @override
  String get letsGo => 'Поїхали!';

  @override
  String get eventsTitle => 'Події';

  @override
  String get searchTitle => 'Пошук';

  @override
  String get profileTitle => 'Профіль';

  @override
  String get signIn => 'Увійти';

  @override
  String get signOut => 'Вийти';

  @override
  String get editProfile => 'Редагувати профіль';

  @override
  String get originCountry => 'Країна походження';

  @override
  String get currentCity => 'Поточне місто';

  @override
  String get joined => 'Приєднався';

  @override
  String get notSet => 'Не вказано';

  @override
  String fromCountry(String country) {
    return 'З $country';
  }

  @override
  String inCity(String city) {
    return 'у $city';
  }

  @override
  String get joinToDiscover => 'Приєднуйтесь до спільноти, щоб знаходити події';

  @override
  String get createAccount => 'Створити акаунт';

  @override
  String get concerts => 'Концерти';

  @override
  String get sports => 'Спорт';

  @override
  String get standUp => 'Стендап';

  @override
  String get business => 'Бізнес';

  @override
  String get kids => 'Діти';

  @override
  String get theatre => 'Театр';

  @override
  String get festivals => 'Фестивалі';

  @override
  String get artExhibitions => 'Мистецтво і виставки';

  @override
  String get buyTicket => 'Купити квиток';

  @override
  String get eventDetails => 'Деталі події';

  @override
  String get noEventsFound => 'Подій не знайдено';

  @override
  String get loading => 'Завантаження...';

  @override
  String get error => 'Щось пішло не так';

  @override
  String get retry => 'Повторити';
}
