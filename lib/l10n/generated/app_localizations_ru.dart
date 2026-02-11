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

  @override
  String get discoverEvents => 'Открывай события';

  @override
  String get discoverSubtitle => 'Найди своих людей, найди свои события';

  @override
  String get searchHint => 'Поиск событий, артистов, площадок...';

  @override
  String get forYou => 'Для вас';

  @override
  String get nearby => 'Рядом';

  @override
  String get categories => 'Категории';

  @override
  String get featuredEvents => 'Рекомендуемые';

  @override
  String get allEvents => 'Все события';

  @override
  String get failedToLoad => 'Не удалось загрузить события';

  @override
  String get tryAgain => 'Попробовать снова';

  @override
  String get noEventsYet => 'Событий пока нет';

  @override
  String get checkBackLater => 'Загляните позже — новые события появятся скоро';

  @override
  String get eventsNearYou => 'События рядом с вами';

  @override
  String get enableLocationHint =>
      'Разрешите доступ к геолокации, чтобы\nнаходить события поблизости';

  @override
  String get enableLocation => 'Включить геолокацию';

  @override
  String get all => 'Все';

  @override
  String get searchForEvents => 'Поиск событий';

  @override
  String get searchSubtitle =>
      'Найдите концерты, фестивали, выставки\nи многое другое в вашем районе';

  @override
  String get noResults => 'Ничего не найдено';

  @override
  String tryDifferentKeywords(String query) {
    return 'Попробуйте другие ключевые слова для «$query»';
  }

  @override
  String get searchUnavailable => 'Поиск недоступен';

  @override
  String get promotedEvent => '⭐ Рекомендуемое событие';

  @override
  String get promoted => '⭐ Рекомендуемое';

  @override
  String get about => 'Описание';

  @override
  String peopleGoing(int count) {
    return '$count участников';
  }

  @override
  String get imGoing => 'Я иду';

  @override
  String get imGoingExcited => 'Я иду!';

  @override
  String get beFirstToJoin => 'Будьте первым!';

  @override
  String get going => 'идут';

  @override
  String get joinCommunity => 'Присоединяйтесь';

  @override
  String get signInSubtitle =>
      'Войдите, чтобы сохранять события,\nобщаться с диаспорой и не только';

  @override
  String get navDiscover => 'Обзор';

  @override
  String get navSearch => 'Поиск';

  @override
  String get navProfile => 'Профиль';

  @override
  String get failedToLoadEvent => 'Не удалось загрузить событие';

  @override
  String get failedToLoadCategories => 'Не удалось загрузить категории';

  @override
  String get diasporaMember => 'Участник диаспоры';
}
