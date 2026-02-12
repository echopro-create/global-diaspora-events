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
  String get signUp => 'Sign Up';

  @override
  String get signInWithGoogle => 'Continue with Google';

  @override
  String get signInWithApple => 'Continue with Apple';

  @override
  String get orContinueWithEmail => 'or continue with email';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get alreadyHaveAccount => 'Already have an account? Sign In';

  @override
  String get dontHaveAccount => 'Don\'t have an account? Sign Up';

  @override
  String get locationPermissionDenied =>
      'Location permission denied. Open Settings to grant access.';

  @override
  String get locationServicesDisabled =>
      'Location services are disabled. Please enable them.';

  @override
  String noNearbyEvents(int radius) {
    return 'No events found within $radius km';
  }

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

  @override
  String get discoverEvents => 'Адкрывай падзеі';

  @override
  String get discoverSubtitle => 'Знайдзі сваіх людзей, знайдзі свае падзеі';

  @override
  String get searchHint => 'Пошук падзей, артыстаў, пляцовак...';

  @override
  String get forYou => 'Для вас';

  @override
  String get nearby => 'Побач';

  @override
  String get categories => 'Катэгорыі';

  @override
  String get featuredEvents => 'Рэкамендаваныя';

  @override
  String get allEvents => 'Усе падзеі';

  @override
  String get failedToLoad => 'Не атрымалася загрузіць падзеі';

  @override
  String get tryAgain => 'Паспрабаваць зноў';

  @override
  String get noEventsYet => 'Падзей пакуль няма';

  @override
  String get checkBackLater =>
      'Завітайце пазней — новыя падзеі з\'явяцца хутка';

  @override
  String get eventsNearYou => 'Падзеі побач з вамі';

  @override
  String get enableLocationHint =>
      'Дазвольце доступ да геалакацыі, каб\nзнаходзіць падзеі паблізу';

  @override
  String get enableLocation => 'Уключыць геалакацыю';

  @override
  String get all => 'Усе';

  @override
  String get searchForEvents => 'Пошук падзей';

  @override
  String get searchSubtitle =>
      'Знайдзіце канцэрты, фестывалі, выставы\nі шмат іншага ў вашым раёне';

  @override
  String get noResults => 'Нічога не знойдзена';

  @override
  String tryDifferentKeywords(String query) {
    return 'Паспрабуйце іншыя ключавыя словы для «$query»';
  }

  @override
  String get searchUnavailable => 'Пошук недаступны';

  @override
  String get promotedEvent => '⭐ Рэкамендаваная падзея';

  @override
  String get promoted => '⭐ Рэкамендаваная';

  @override
  String get about => 'Апісанне';

  @override
  String peopleGoing(int count) {
    return '$count удзельнікаў';
  }

  @override
  String get imGoing => 'Я іду';

  @override
  String get imGoingExcited => 'Я іду!';

  @override
  String get beFirstToJoin => 'Будзьце першым!';

  @override
  String get going => 'ідуць';

  @override
  String get joinCommunity => 'Далучайцеся';

  @override
  String get signInSubtitle =>
      'Увайдзіце, каб захоўваць падзеі,\nзносіцца з дыяспарай і не толькі';

  @override
  String get navDiscover => 'Агляд';

  @override
  String get navSearch => 'Пошук';

  @override
  String get navProfile => 'Профіль';

  @override
  String get failedToLoadEvent => 'Не атрымалася загрузіць падзею';

  @override
  String get failedToLoadCategories => 'Не атрымалася загрузіць катэгорыі';

  @override
  String get diasporaMember => 'Удзельнік дыяспары';

  @override
  String get attending => 'Attending';

  @override
  String get cancelAttendance => 'Cancel attendance';

  @override
  String attendeesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count attendees',
      one: '1 attendee',
      zero: 'No attendees yet',
    );
    return '$_temp0';
  }

  @override
  String get mapView => 'Map View';

  @override
  String get listView => 'List View';

  @override
  String get directions => 'Directions';

  @override
  String get shareEvent => 'Share Event';

  @override
  String get eventSaved => 'Event saved!';

  @override
  String get eventRemoved => 'Event removed from saved';

  @override
  String get signInToAttend => 'Sign in to mark attendance';

  @override
  String get free => 'Free';

  @override
  String startsIn(String time) {
    return 'Starts in $time';
  }

  @override
  String get happeningNow => 'Happening now';

  @override
  String get eventEnded => 'Event ended';

  @override
  String daysShort(int count) {
    return '${count}d';
  }

  @override
  String hoursShort(int count) {
    return '${count}h';
  }

  @override
  String minutesShort(int count) {
    return '${count}m';
  }

  @override
  String get networkError => 'Network error. Check your connection';

  @override
  String get offlineMode => 'Offline mode — showing cached data';

  @override
  String get loginToParticipate => 'Log in to mark attendance';

  @override
  String get addToCalendar => 'Add to Calendar';

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
