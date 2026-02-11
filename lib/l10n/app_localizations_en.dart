// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

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

  @override
  String get discoverEvents => 'Discover Events';

  @override
  String get discoverSubtitle => 'Find your people, find your events';

  @override
  String get searchHint => 'Search events, artists, venues...';

  @override
  String get forYou => 'For You';

  @override
  String get nearby => 'Nearby';

  @override
  String get categories => 'Categories';

  @override
  String get featuredEvents => 'Featured Events';

  @override
  String get allEvents => 'All Events';

  @override
  String get failedToLoad => 'Failed to load events';

  @override
  String get tryAgain => 'Try again';

  @override
  String get noEventsYet => 'No events yet';

  @override
  String get checkBackLater => 'Check back later for upcoming events';

  @override
  String get eventsNearYou => 'Events near you';

  @override
  String get enableLocationHint =>
      'Enable location access to discover\nevents happening around you';

  @override
  String get enableLocation => 'Enable Location';

  @override
  String get all => 'All';

  @override
  String get searchForEvents => 'Search for events';

  @override
  String get searchSubtitle =>
      'Find concerts, festivals, exhibitions\nand more in your area';

  @override
  String get noResults => 'No results found';

  @override
  String tryDifferentKeywords(String query) {
    return 'Try different keywords for \"$query\"';
  }

  @override
  String get searchUnavailable => 'Search unavailable';

  @override
  String get promotedEvent => '⭐ Promoted Event';

  @override
  String get promoted => '⭐ Promoted';

  @override
  String get about => 'About';

  @override
  String peopleGoing(int count) {
    return '$count people going';
  }

  @override
  String get imGoing => 'I\'m going';

  @override
  String get imGoingExcited => 'I\'m going!';

  @override
  String get beFirstToJoin => 'Be the first to join!';

  @override
  String get going => 'going';

  @override
  String get joinCommunity => 'Join the community';

  @override
  String get signInSubtitle =>
      'Sign in to save events, connect\nwith your diaspora and more';

  @override
  String get navDiscover => 'Discover';

  @override
  String get navSearch => 'Search';

  @override
  String get navProfile => 'Profile';

  @override
  String get failedToLoadEvent => 'Failed to load event';

  @override
  String get failedToLoadCategories => 'Failed to load categories';

  @override
  String get diasporaMember => 'Diaspora Member';
}
