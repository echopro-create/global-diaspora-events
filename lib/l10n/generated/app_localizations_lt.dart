// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

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
