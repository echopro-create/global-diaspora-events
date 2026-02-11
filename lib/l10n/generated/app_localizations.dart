import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_az.dart';
import 'app_localizations_be.dart';
import 'app_localizations_en.dart';
import 'app_localizations_et.dart';
import 'app_localizations_hy.dart';
import 'app_localizations_ka.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_ky.dart';
import 'app_localizations_lt.dart';
import 'app_localizations_lv.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tg.dart';
import 'app_localizations_tk.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('az'),
    Locale('be'),
    Locale('en'),
    Locale('et'),
    Locale('hy'),
    Locale('ka'),
    Locale('kk'),
    Locale('ky'),
    Locale('lt'),
    Locale('lv'),
    Locale('ru'),
    Locale('tg'),
    Locale('tk'),
    Locale('uk'),
    Locale('uz'),
  ];

  /// Auto-generated description for appTitle
  ///
  /// In en, this message translates to:
  /// **'Global Diaspora Events'**
  String get appTitle;

  /// Auto-generated description for welcomeTitle
  ///
  /// In en, this message translates to:
  /// **'Welcome to\nGlobal Diaspora Events'**
  String get welcomeTitle;

  /// Auto-generated description for welcomeSubtitle
  ///
  /// In en, this message translates to:
  /// **'Find your people.\nFind your events.\nStay connected to your culture.'**
  String get welcomeSubtitle;

  /// Auto-generated description for whereAreYouFrom
  ///
  /// In en, this message translates to:
  /// **'Where are you from?'**
  String get whereAreYouFrom;

  /// Auto-generated description for countryHint
  ///
  /// In en, this message translates to:
  /// **'This helps us find events from your culture'**
  String get countryHint;

  /// Auto-generated description for whatAreYouInto
  ///
  /// In en, this message translates to:
  /// **'What are you into?'**
  String get whatAreYouInto;

  /// Auto-generated description for interestsHint
  ///
  /// In en, this message translates to:
  /// **'Pick at least one to personalize your feed'**
  String get interestsHint;

  /// Auto-generated description for next
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Auto-generated description for back
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Auto-generated description for letsGo
  ///
  /// In en, this message translates to:
  /// **'Let\'s go!'**
  String get letsGo;

  /// Auto-generated description for eventsTitle
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get eventsTitle;

  /// Auto-generated description for searchTitle
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// Auto-generated description for profileTitle
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// Auto-generated description for signIn
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Sign out button label
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// Sign up button label
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Google sign-in button label
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get signInWithGoogle;

  /// Apple sign-in button label
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get signInWithApple;

  /// Divider label between OAuth and email form
  ///
  /// In en, this message translates to:
  /// **'or continue with email'**
  String get orContinueWithEmail;

  /// Email field hint
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field hint
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Toggle to sign-in mode
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign In'**
  String get alreadyHaveAccount;

  /// Toggle to sign-up mode
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign Up'**
  String get dontHaveAccount;

  /// Shown when location permission is denied
  ///
  /// In en, this message translates to:
  /// **'Location permission denied. Open Settings to grant access.'**
  String get locationPermissionDenied;

  /// Shown when device location is off
  ///
  /// In en, this message translates to:
  /// **'Location services are disabled. Please enable them.'**
  String get locationServicesDisabled;

  /// Shown when no events are nearby
  ///
  /// In en, this message translates to:
  /// **'No events found within {radius} km'**
  String noNearbyEvents(int radius);

  /// Auto-generated description for editProfile
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// Auto-generated description for originCountry
  ///
  /// In en, this message translates to:
  /// **'Origin Country'**
  String get originCountry;

  /// Auto-generated description for currentCity
  ///
  /// In en, this message translates to:
  /// **'Current City'**
  String get currentCity;

  /// Auto-generated description for joined
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get joined;

  /// Auto-generated description for notSet
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @fromCountry.
  ///
  /// In en, this message translates to:
  /// **'From {country}'**
  String fromCountry(String country);

  /// No description provided for @inCity.
  ///
  /// In en, this message translates to:
  /// **'in {city}'**
  String inCity(String city);

  /// Auto-generated description for joinToDiscover
  ///
  /// In en, this message translates to:
  /// **'Join our community to discover events'**
  String get joinToDiscover;

  /// Auto-generated description for createAccount
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Auto-generated description for concerts
  ///
  /// In en, this message translates to:
  /// **'Concerts'**
  String get concerts;

  /// Auto-generated description for sports
  ///
  /// In en, this message translates to:
  /// **'Sports'**
  String get sports;

  /// Auto-generated description for standUp
  ///
  /// In en, this message translates to:
  /// **'Stand-Up'**
  String get standUp;

  /// Auto-generated description for business
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// Auto-generated description for kids
  ///
  /// In en, this message translates to:
  /// **'Kids'**
  String get kids;

  /// Auto-generated description for theatre
  ///
  /// In en, this message translates to:
  /// **'Theatre'**
  String get theatre;

  /// Auto-generated description for festivals
  ///
  /// In en, this message translates to:
  /// **'Festivals'**
  String get festivals;

  /// Auto-generated description for artExhibitions
  ///
  /// In en, this message translates to:
  /// **'Art & Exhibitions'**
  String get artExhibitions;

  /// Auto-generated description for buyTicket
  ///
  /// In en, this message translates to:
  /// **'Buy Ticket'**
  String get buyTicket;

  /// Auto-generated description for eventDetails
  ///
  /// In en, this message translates to:
  /// **'Event Details'**
  String get eventDetails;

  /// Auto-generated description for noEventsFound
  ///
  /// In en, this message translates to:
  /// **'No events found'**
  String get noEventsFound;

  /// Auto-generated description for loading
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Auto-generated description for error
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get error;

  /// Auto-generated description for retry
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Auto-generated description for discoverEvents
  ///
  /// In en, this message translates to:
  /// **'Discover Events'**
  String get discoverEvents;

  /// Auto-generated description for discoverSubtitle
  ///
  /// In en, this message translates to:
  /// **'Find your people, find your events'**
  String get discoverSubtitle;

  /// Auto-generated description for searchHint
  ///
  /// In en, this message translates to:
  /// **'Search events, artists, venues...'**
  String get searchHint;

  /// Auto-generated description for forYou
  ///
  /// In en, this message translates to:
  /// **'For You'**
  String get forYou;

  /// Auto-generated description for nearby
  ///
  /// In en, this message translates to:
  /// **'Nearby'**
  String get nearby;

  /// Auto-generated description for categories
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// Auto-generated description for featuredEvents
  ///
  /// In en, this message translates to:
  /// **'Featured Events'**
  String get featuredEvents;

  /// Auto-generated description for allEvents
  ///
  /// In en, this message translates to:
  /// **'All Events'**
  String get allEvents;

  /// Auto-generated description for failedToLoad
  ///
  /// In en, this message translates to:
  /// **'Failed to load events'**
  String get failedToLoad;

  /// Auto-generated description for tryAgain
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// Auto-generated description for noEventsYet
  ///
  /// In en, this message translates to:
  /// **'No events yet'**
  String get noEventsYet;

  /// Auto-generated description for checkBackLater
  ///
  /// In en, this message translates to:
  /// **'Check back later for upcoming events'**
  String get checkBackLater;

  /// Auto-generated description for eventsNearYou
  ///
  /// In en, this message translates to:
  /// **'Events near you'**
  String get eventsNearYou;

  /// Auto-generated description for enableLocationHint
  ///
  /// In en, this message translates to:
  /// **'Enable location access to discover\nevents happening around you'**
  String get enableLocationHint;

  /// Auto-generated description for enableLocation
  ///
  /// In en, this message translates to:
  /// **'Enable Location'**
  String get enableLocation;

  /// Auto-generated description for all
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// Auto-generated description for searchForEvents
  ///
  /// In en, this message translates to:
  /// **'Search for events'**
  String get searchForEvents;

  /// Auto-generated description for searchSubtitle
  ///
  /// In en, this message translates to:
  /// **'Find concerts, festivals, exhibitions\nand more in your area'**
  String get searchSubtitle;

  /// Auto-generated description for noResults
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// No description provided for @tryDifferentKeywords.
  ///
  /// In en, this message translates to:
  /// **'Try different keywords for \"{query}\"'**
  String tryDifferentKeywords(String query);

  /// Auto-generated description for searchUnavailable
  ///
  /// In en, this message translates to:
  /// **'Search unavailable'**
  String get searchUnavailable;

  /// Auto-generated description for promotedEvent
  ///
  /// In en, this message translates to:
  /// **'⭐ Promoted Event'**
  String get promotedEvent;

  /// Auto-generated description for promoted
  ///
  /// In en, this message translates to:
  /// **'⭐ Promoted'**
  String get promoted;

  /// Auto-generated description for about
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @peopleGoing.
  ///
  /// In en, this message translates to:
  /// **'{count} people going'**
  String peopleGoing(int count);

  /// Auto-generated description for imGoing
  ///
  /// In en, this message translates to:
  /// **'I\'m going'**
  String get imGoing;

  /// Auto-generated description for imGoingExcited
  ///
  /// In en, this message translates to:
  /// **'I\'m going!'**
  String get imGoingExcited;

  /// Auto-generated description for beFirstToJoin
  ///
  /// In en, this message translates to:
  /// **'Be the first to join!'**
  String get beFirstToJoin;

  /// Auto-generated description for going
  ///
  /// In en, this message translates to:
  /// **'going'**
  String get going;

  /// Auto-generated description for joinCommunity
  ///
  /// In en, this message translates to:
  /// **'Join the community'**
  String get joinCommunity;

  /// Auto-generated description for signInSubtitle
  ///
  /// In en, this message translates to:
  /// **'Sign in to save events, connect\nwith your diaspora and more'**
  String get signInSubtitle;

  /// Auto-generated description for navDiscover
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get navDiscover;

  /// Auto-generated description for navSearch
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get navSearch;

  /// Auto-generated description for navProfile
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// Auto-generated description for failedToLoadEvent
  ///
  /// In en, this message translates to:
  /// **'Failed to load event'**
  String get failedToLoadEvent;

  /// Auto-generated description for failedToLoadCategories
  ///
  /// In en, this message translates to:
  /// **'Failed to load categories'**
  String get failedToLoadCategories;

  /// Auto-generated description for diasporaMember
  ///
  /// In en, this message translates to:
  /// **'Diaspora Member'**
  String get diasporaMember;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'az',
    'be',
    'en',
    'et',
    'hy',
    'ka',
    'kk',
    'ky',
    'lt',
    'lv',
    'ru',
    'tg',
    'tk',
    'uk',
    'uz',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'az':
      return AppLocalizationsAz();
    case 'be':
      return AppLocalizationsBe();
    case 'en':
      return AppLocalizationsEn();
    case 'et':
      return AppLocalizationsEt();
    case 'hy':
      return AppLocalizationsHy();
    case 'ka':
      return AppLocalizationsKa();
    case 'kk':
      return AppLocalizationsKk();
    case 'ky':
      return AppLocalizationsKy();
    case 'lt':
      return AppLocalizationsLt();
    case 'lv':
      return AppLocalizationsLv();
    case 'ru':
      return AppLocalizationsRu();
    case 'tg':
      return AppLocalizationsTg();
    case 'tk':
      return AppLocalizationsTk();
    case 'uk':
      return AppLocalizationsUk();
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
