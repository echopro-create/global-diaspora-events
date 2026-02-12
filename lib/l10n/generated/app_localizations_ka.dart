// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Georgian (`ka`).
class AppLocalizationsKa extends AppLocalizations {
  AppLocalizationsKa([String locale = 'ka']) : super(locale);

  @override
  String get appTitle => 'Global Diaspora Events';

  @override
  String get welcomeTitle =>
      'კეთილი იყოს თქვენი მობრძანება\nGlobal Diaspora Events-ში';

  @override
  String get welcomeSubtitle =>
      'იპოვე შენი ხალხი.\nიპოვე შენი ღონისძიებები.\nდარჩი კავშირზე შენს კულტურასთან.';

  @override
  String get whereAreYouFrom => 'საიდან ხართ?';

  @override
  String get countryHint =>
      'ეს დაგვეხმარება თქვენი კულტურის ღონისძიებების პოვნაში';

  @override
  String get whatAreYouInto => 'რა გაინტერესებთ?';

  @override
  String get interestsHint => 'აირჩიეთ მინიმუმ ერთი ფიდის პერსონალიზაციისთვის';

  @override
  String get next => 'შემდეგი';

  @override
  String get back => 'უკან';

  @override
  String get letsGo => 'წავედით!';

  @override
  String get eventsTitle => 'ღონისძიებები';

  @override
  String get searchTitle => 'ძიება';

  @override
  String get profileTitle => 'პროფილი';

  @override
  String get signIn => 'შესვლა';

  @override
  String get signOut => 'გასვლა';

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
  String get editProfile => 'პროფილის რედაქტირება';

  @override
  String get originCountry => 'წარმოშობის ქვეყანა';

  @override
  String get currentCity => 'მიმდინარე ქალაქი';

  @override
  String get joined => 'შეუერთდა';

  @override
  String get notSet => 'არ არის მითითებული';

  @override
  String fromCountry(String country) {
    return '$country-დან';
  }

  @override
  String inCity(String city) {
    return '$city-ში';
  }

  @override
  String get joinToDiscover =>
      'შეუერთდით საზოგადოებას ღონისძიებების აღმოსაჩენად';

  @override
  String get createAccount => 'ანგარიშის შექმნა';

  @override
  String get concerts => 'კონცერტები';

  @override
  String get sports => 'სპორტი';

  @override
  String get standUp => 'სტენდაპი';

  @override
  String get business => 'ბიზნესი';

  @override
  String get kids => 'ბავშვები';

  @override
  String get theatre => 'თეატრი';

  @override
  String get festivals => 'ფესტივალები';

  @override
  String get artExhibitions => 'ხელოვნება და გამოფენები';

  @override
  String get buyTicket => 'ბილეთის ყიდვა';

  @override
  String get eventDetails => 'ღონისძიების დეტალები';

  @override
  String get noEventsFound => 'ღონისძიებები ვერ მოიძებნა';

  @override
  String get loading => 'იტვირთება...';

  @override
  String get error => 'რაღაც შეცდომა მოხდა';

  @override
  String get retry => 'ხელახლა ცდა';

  @override
  String get discoverEvents => 'აღმოაჩინე ღონისძიებები';

  @override
  String get discoverSubtitle => 'იპოვე შენი ხალხი, იპოვე შენი ღონისძიებები';

  @override
  String get searchHint => 'ღონისძიებების, არტისტების, სივრცეების ძიება...';

  @override
  String get forYou => 'თქვენთვის';

  @override
  String get nearby => 'ახლოს';

  @override
  String get categories => 'კატეგორიები';

  @override
  String get featuredEvents => 'რეკომენდებული';

  @override
  String get allEvents => 'ყველა ღონისძიება';

  @override
  String get failedToLoad => 'ღონისძიებების ჩატვირთვა ვერ მოხერხდა';

  @override
  String get tryAgain => 'ხელახლა ცდა';

  @override
  String get noEventsYet => 'ღონისძიებები ჯერ არ არის';

  @override
  String get checkBackLater =>
      'შეამოწმეთ მოგვიანებით — ახალი ღონისძიებები მალე გამოჩნდება';

  @override
  String get eventsNearYou => 'ღონისძიებები თქვენს მახლობლად';

  @override
  String get enableLocationHint =>
      'გეოლოკაციაზე წვდომის ნებართვა\nახლომახლო ღონისძიებების საპოვნელად';

  @override
  String get enableLocation => 'გეოლოკაციის ჩართვა';

  @override
  String get all => 'ყველა';

  @override
  String get searchForEvents => 'ღონისძიებების ძიება';

  @override
  String get searchSubtitle =>
      'იპოვეთ კონცერტები, ფესტივალები, გამოფენები\nდა სხვა მრავალი თქვენს ახლოს';

  @override
  String get noResults => 'ვერაფერი მოიძებნა';

  @override
  String tryDifferentKeywords(String query) {
    return 'სცადეთ სხვა საკვანძო სიტყვები «$query»-თვის';
  }

  @override
  String get searchUnavailable => 'ძიება მიუწვდომელია';

  @override
  String get promotedEvent => '⭐ რეკომენდებული ღონისძიება';

  @override
  String get promoted => '⭐ რეკომენდებული';

  @override
  String get about => 'აღწერა';

  @override
  String peopleGoing(int count) {
    return '$count მონაწილე';
  }

  @override
  String get imGoing => 'მე მივდივარ';

  @override
  String get imGoingExcited => 'მე მივდივარ!';

  @override
  String get beFirstToJoin => 'იყავით პირველი!';

  @override
  String get going => 'მიდიან';

  @override
  String get joinCommunity => 'შემოგვიერთდით';

  @override
  String get signInSubtitle =>
      'შედით, რომ შეინახოთ ღონისძიებები,\nდაუკავშირდეთ დიასპორას და სხვა';

  @override
  String get navDiscover => 'მიმოხილვა';

  @override
  String get navSearch => 'ძიება';

  @override
  String get navProfile => 'პროფილი';

  @override
  String get failedToLoadEvent => 'ღონისძიების ჩატვირთვა ვერ მოხერხდა';

  @override
  String get failedToLoadCategories => 'კატეგორიების ჩატვირთვა ვერ მოხერხდა';

  @override
  String get diasporaMember => 'დიასპორის წევრი';

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
