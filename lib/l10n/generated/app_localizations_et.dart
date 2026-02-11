// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get appTitle => 'Global Diaspora Events';

  @override
  String get welcomeTitle => 'Welcome to\nGlobal Diaspora Events';

  @override
  String get welcomeSubtitle =>
      'Find your people.\nFind your events.\nStay connected to your culture.';

  @override
  String get whereAreYouFrom => 'Where are you from?';

  @override
  String get countryHint => 'This helps us find events from your culture';

  @override
  String get whatAreYouInto => 'What are you into?';

  @override
  String get interestsHint => 'Pick at least one to personalize your feed';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get letsGo => 'Let\'s go!';

  @override
  String get eventsTitle => 'Events';

  @override
  String get searchTitle => 'Search';

  @override
  String get profileTitle => 'Profile';

  @override
  String get signIn => 'Sign In';

  @override
  String get signOut => 'Sign Out';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get originCountry => 'Origin Country';

  @override
  String get currentCity => 'Current City';

  @override
  String get joined => 'Joined';

  @override
  String get notSet => 'Not set';

  @override
  String fromCountry(String country) {
    return 'From $country';
  }

  @override
  String inCity(String city) {
    return 'in $city';
  }

  @override
  String get joinToDiscover => 'Join our community to discover events';

  @override
  String get createAccount => 'Create Account';

  @override
  String get concerts => 'Concerts';

  @override
  String get sports => 'Sports';

  @override
  String get standUp => 'Stand-Up';

  @override
  String get business => 'Business';

  @override
  String get kids => 'Kids';

  @override
  String get theatre => 'Theatre';

  @override
  String get festivals => 'Festivals';

  @override
  String get artExhibitions => 'Art & Exhibitions';

  @override
  String get buyTicket => 'Buy Ticket';

  @override
  String get eventDetails => 'Event Details';

  @override
  String get noEventsFound => 'No events found';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Something went wrong';

  @override
  String get retry => 'Retry';
}
