// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Belarusian (`be`).
class AppLocalizationsBe extends AppLocalizations {
  AppLocalizationsBe([String locale = 'be']) : super(locale);

  @override
  String get appTitle => 'Global Diaspora Events';

  @override
  String get welcomeTitle => 'Вітаем у\nGlobal Diaspora Events';

  @override
  String get welcomeSubtitle =>
      'Знайдзі сваіх людзей.\nЗнайдзі свае падзеі.\nЗаставайся на сувязі са сваёй культурай.';

  @override
  String get whereAreYouFrom => 'Адкуль вы?';

  @override
  String get countryHint => 'Гэта дапаможа нам знайсці падзеі вашай культуры';

  @override
  String get whatAreYouInto => 'Чым цікавіцеся?';

  @override
  String get interestsHint => 'Абярыце хоць бы адно для персаналізацыі стужкі';

  @override
  String get next => 'Далей';

  @override
  String get back => 'Назад';

  @override
  String get letsGo => 'Паехалі!';

  @override
  String get eventsTitle => 'Падзеі';

  @override
  String get searchTitle => 'Пошук';

  @override
  String get profileTitle => 'Профіль';

  @override
  String get signIn => 'Увайсці';

  @override
  String get signOut => 'Выйсці';

  @override
  String get editProfile => 'Рэдагаваць профіль';

  @override
  String get originCountry => 'Краіна паходжання';

  @override
  String get currentCity => 'Бягучы горад';

  @override
  String get joined => 'Далучыўся';

  @override
  String get notSet => 'Не ўказана';

  @override
  String fromCountry(String country) {
    return 'З $country';
  }

  @override
  String inCity(String city) {
    return 'у $city';
  }

  @override
  String get joinToDiscover =>
      'Далучайцеся да супольнасці, каб знаходзіць падзеі';

  @override
  String get createAccount => 'Стварыць акаўнт';

  @override
  String get concerts => 'Канцэрты';

  @override
  String get sports => 'Спорт';

  @override
  String get standUp => 'Стэндап';

  @override
  String get business => 'Бізнес';

  @override
  String get kids => 'Дзеці';

  @override
  String get theatre => 'Тэатр';

  @override
  String get festivals => 'Фестывалі';

  @override
  String get artExhibitions => 'Мастацтва і выставы';

  @override
  String get buyTicket => 'Купіць білет';

  @override
  String get eventDetails => 'Падрабязнасці падзеі';

  @override
  String get noEventsFound => 'Падзей не знойдзена';

  @override
  String get loading => 'Загрузка...';

  @override
  String get error => 'Нешта пайшло не так';

  @override
  String get retry => 'Паўтарыць';
}
