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
  String get loginTitle => 'Welcome Back';

  @override
  String get loginSubtitle => 'Connect with your community worldwide';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginButton => 'Sign In';

  @override
  String get signUpButton => 'Create Account';

  @override
  String get googleSignIn => 'Continue with Google';

  @override
  String get appleSignIn => 'Continue with Apple';

  @override
  String get eventsFeedTitle => 'Discovery';

  @override
  String get noEventsFound => 'No events found in your area';

  @override
  String get profileTitle => 'My Profile';

  @override
  String get interestsTitle => 'Interests';
}
