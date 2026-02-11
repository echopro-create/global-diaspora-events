// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Global Diaspora Events';

  @override
  String get welcomeTitle => 'Добро пожаловать в\nGlobal Diaspora Events';

  @override
  String get welcomeSubtitle =>
      'Найди своих людей.\nНайди свои события.\nОставайся на связи со своей культурой.';

  @override
  String get whereAreYouFrom => 'Откуда вы?';

  @override
  String get countryHint => 'Это поможет нам найти события вашей культуры';

  @override
  String get whatAreYouInto => 'Что вас интересует?';

  @override
  String get interestsHint => 'Выберите хотя бы одно для персонализации ленты';

  @override
  String get next => 'Далее';

  @override
  String get back => 'Назад';

  @override
  String get letsGo => 'Поехали!';

  @override
  String get eventsTitle => 'События';

  @override
  String get searchTitle => 'Поиск';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get signIn => 'Войти';

  @override
  String get signOut => 'Выйти';

  @override
  String get editProfile => 'Редактировать профиль';

  @override
  String get originCountry => 'Страна происхождения';

  @override
  String get currentCity => 'Текущий город';

  @override
  String get joined => 'Присоединился';

  @override
  String get notSet => 'Не указано';

  @override
  String fromCountry(String country) {
    return 'Из $country';
  }

  @override
  String inCity(String city) {
    return 'в $city';
  }

  @override
  String get joinToDiscover =>
      'Присоединяйтесь к сообществу, чтобы находить события';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get concerts => 'Концерты';

  @override
  String get sports => 'Спорт';

  @override
  String get standUp => 'Стендап';

  @override
  String get business => 'Бизнес';

  @override
  String get kids => 'Дети';

  @override
  String get theatre => 'Театр';

  @override
  String get festivals => 'Фестивали';

  @override
  String get artExhibitions => 'Искусство и выставки';

  @override
  String get buyTicket => 'Купить билет';

  @override
  String get eventDetails => 'Подробности события';

  @override
  String get noEventsFound => 'Событий не найдено';

  @override
  String get loading => 'Загрузка...';

  @override
  String get error => 'Что-то пошло не так';

  @override
  String get retry => 'Повторить';
}
