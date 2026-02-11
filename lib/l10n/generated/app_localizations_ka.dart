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
}
