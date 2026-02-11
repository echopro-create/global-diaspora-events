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
}
