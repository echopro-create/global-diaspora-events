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
  String get signUp => 'Реєстрація';

  @override
  String get signInWithGoogle => 'Увійти через Google';

  @override
  String get signInWithApple => 'Увійти через Apple';

  @override
  String get orContinueWithEmail => 'або продовжити з email';

  @override
  String get email => 'Email';

  @override
  String get password => 'Пароль';

  @override
  String get alreadyHaveAccount => 'Вже є акаунт? Увійти';

  @override
  String get dontHaveAccount => 'Немає акаунту? Зареєструватися';

  @override
  String get locationPermissionDenied =>
      'Доступ до геолокації заборонено. Відкрийте налаштування.';

  @override
  String get locationServicesDisabled =>
      'Геолокацію вимкнено. Будь ласка, увімкніть її.';

  @override
  String noNearbyEvents(int radius) {
    return 'Немає подій у радіусі $radius км';
  }

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

  @override
  String get discoverEvents => 'Відкривай події';

  @override
  String get discoverSubtitle => 'Знайди своїх людей, знайди свої події';

  @override
  String get searchHint => 'Пошук подій, артистів, майданчиків...';

  @override
  String get forYou => 'Для вас';

  @override
  String get nearby => 'Поруч';

  @override
  String get categories => 'Категорії';

  @override
  String get featuredEvents => 'Рекомендовані';

  @override
  String get allEvents => 'Усі події';

  @override
  String get failedToLoad => 'Не вдалося завантажити події';

  @override
  String get tryAgain => 'Спробувати знову';

  @override
  String get noEventsYet => 'Подій поки немає';

  @override
  String get checkBackLater =>
      'Завітайте пізніше — нові події з\'являться незабаром';

  @override
  String get eventsNearYou => 'Події поруч з вами';

  @override
  String get enableLocationHint =>
      'Дозвольте доступ до геолокації, щоб\nзнаходити події поблизу';

  @override
  String get enableLocation => 'Увімкнути геолокацію';

  @override
  String get all => 'Усі';

  @override
  String get searchForEvents => 'Пошук подій';

  @override
  String get searchSubtitle =>
      'Знайдіть концерти, фестивалі, виставки\nта багато іншого у вашому районі';

  @override
  String get noResults => 'Нічого не знайдено';

  @override
  String tryDifferentKeywords(String query) {
    return 'Спробуйте інші ключові слова для «$query»';
  }

  @override
  String get searchUnavailable => 'Пошук недоступний';

  @override
  String get promotedEvent => '⭐ Рекомендована подія';

  @override
  String get promoted => '⭐ Рекомендована';

  @override
  String get about => 'Опис';

  @override
  String peopleGoing(int count) {
    return '$count учасників';
  }

  @override
  String get imGoing => 'Я йду';

  @override
  String get imGoingExcited => 'Я йду!';

  @override
  String get beFirstToJoin => 'Будьте першим!';

  @override
  String get going => 'йдуть';

  @override
  String get joinCommunity => 'Приєднуйтесь';

  @override
  String get signInSubtitle =>
      'Увійдіть, щоб зберігати події,\nспілкуватися з діаспорою та не тільки';

  @override
  String get navDiscover => 'Огляд';

  @override
  String get navSearch => 'Пошук';

  @override
  String get navProfile => 'Профіль';

  @override
  String get failedToLoadEvent => 'Не вдалося завантажити подію';

  @override
  String get failedToLoadCategories => 'Не вдалося завантажити категорії';

  @override
  String get diasporaMember => 'Учасник діаспори';

  @override
  String get attending => 'Беру участь';

  @override
  String get cancelAttendance => 'Скасувати участь';

  @override
  String attendeesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count учасників',
      many: '$count учасників',
      few: '$count учасники',
      one: '1 учасник',
      zero: 'Ще немає учасників',
    );
    return '$_temp0';
  }

  @override
  String get mapView => 'На карті';

  @override
  String get listView => 'Списком';

  @override
  String get directions => 'Маршрут';

  @override
  String get shareEvent => 'Поділитися';

  @override
  String get eventSaved => 'Подію збережено!';

  @override
  String get eventRemoved => 'Подію видалено зі збережених';

  @override
  String get signInToAttend => 'Увійдіть, щоб відмітити участь';

  @override
  String get free => 'Безкоштовно';

  @override
  String startsIn(String time) {
    return 'Початок через $time';
  }

  @override
  String get happeningNow => 'Відбувається зараз';

  @override
  String get eventEnded => 'Подія завершилась';

  @override
  String daysShort(int count) {
    return '$countд';
  }

  @override
  String hoursShort(int count) {
    return '$countг';
  }

  @override
  String minutesShort(int count) {
    return '$countхв';
  }

  @override
  String get networkError => 'Помилка мережі. Перевірте з\'єднання';

  @override
  String get offlineMode => 'Офлайн режим — показано збережені дані';

  @override
  String get loginToParticipate => 'Увійдіть, щоб відмітити участь';

  @override
  String get addToCalendar => 'Додати до календаря';

  @override
  String get theme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get myEvents => 'My Events';

  @override
  String get myEventsEmpty => 'You haven\'t joined any events yet';

  @override
  String get myEventsEmptyHint => 'Events you attend will appear here';

  @override
  String get filterAll => 'All';

  @override
  String get filterThisWeek => 'This Week';

  @override
  String get filterThisMonth => 'This Month';
}
