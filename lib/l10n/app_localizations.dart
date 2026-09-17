import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pl'),
    Locale('uk')
  ];

  /// No description provided for @textInstructions.
  ///
  /// In en, this message translates to:
  /// **'Navigate to Accommodation → Settings → Advanced to generate API keys and scan QR code. Or enter your data in the form below.'**
  String get textInstructions;

  /// No description provided for @scanQRCodeButtonText.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get scanQRCodeButtonText;

  /// No description provided for @invalidQRCodeMessage.
  ///
  /// In en, this message translates to:
  /// **'QR code is not valid.'**
  String get invalidQRCodeMessage;

  /// No description provided for @domainLabelText.
  ///
  /// In en, this message translates to:
  /// **'Domain'**
  String get domainLabelText;

  /// No description provided for @domainValidatorMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter domain'**
  String get domainValidatorMessage;

  /// No description provided for @keyLabelText.
  ///
  /// In en, this message translates to:
  /// **'Key'**
  String get keyLabelText;

  /// No description provided for @keyValidatorMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter Key'**
  String get keyValidatorMessage;

  /// No description provided for @secretLabelText.
  ///
  /// In en, this message translates to:
  /// **'Secret'**
  String get secretLabelText;

  /// No description provided for @secretValidatorMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter Secret'**
  String get secretValidatorMessage;

  /// No description provided for @submitButtonText.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButtonText;

  /// No description provided for @calendarLabelText.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendarLabelText;

  /// No description provided for @bookingsLabelText.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookingsLabelText;

  /// No description provided for @paymentsLabelText.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get paymentsLabelText;

  /// No description provided for @settingsLabelText.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsLabelText;

  /// No description provided for @refreshTootlipText.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refreshTootlipText;

  /// No description provided for @filterTootlipText.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filterTootlipText;

  /// No description provided for @nothingFoundText.
  ///
  /// In en, this message translates to:
  /// **'Nothing Found'**
  String get nothingFoundText;

  /// No description provided for @newBookingTooltipText.
  ///
  /// In en, this message translates to:
  /// **'New Booking'**
  String get newBookingTooltipText;

  /// No description provided for @cancelButttonText.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButttonText;

  /// No description provided for @logoutButtonText.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logoutButtonText;

  /// No description provided for @confirmLogoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get confirmLogoutMessage;

  /// No description provided for @consumerKeyEndingInLabelText.
  ///
  /// In en, this message translates to:
  /// **'Consumer key ending in'**
  String get consumerKeyEndingInLabelText;

  /// No description provided for @adultsLabelText.
  ///
  /// In en, this message translates to:
  /// **'Adults'**
  String get adultsLabelText;

  /// No description provided for @childrenLabelText.
  ///
  /// In en, this message translates to:
  /// **'Children'**
  String get childrenLabelText;

  /// No description provided for @rateLabelText.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rateLabelText;

  /// No description provided for @servicesLabelText.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get servicesLabelText;

  /// No description provided for @bookingSetToConfirmedButtonText.
  ///
  /// In en, this message translates to:
  /// **'Set to Confirmed'**
  String get bookingSetToConfirmedButtonText;

  /// No description provided for @bookingSetToCanceledButtonText.
  ///
  /// In en, this message translates to:
  /// **'Set to Canceled'**
  String get bookingSetToCanceledButtonText;

  /// No description provided for @bookingSetToPendingAdminButtonText.
  ///
  /// In en, this message translates to:
  /// **'Set to Pending Admin'**
  String get bookingSetToPendingAdminButtonText;

  /// No description provided for @bookingSetToPendingUserConfirmationButtonText.
  ///
  /// In en, this message translates to:
  /// **'Set to Pending User Confirmation'**
  String get bookingSetToPendingUserConfirmationButtonText;

  /// No description provided for @bookingSetToPendingPaymentButtonText.
  ///
  /// In en, this message translates to:
  /// **'Set to Pending Payment'**
  String get bookingSetToPendingPaymentButtonText;

  /// No description provided for @deleteButtonText.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButtonText;

  /// No description provided for @notSetLabelText.
  ///
  /// In en, this message translates to:
  /// **'not set'**
  String get notSetLabelText;

  /// No description provided for @copiedLabelText.
  ///
  /// In en, this message translates to:
  /// **'copied'**
  String get copiedLabelText;

  /// No description provided for @copyTooltipText.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copyTooltipText;

  /// No description provided for @totalLabelText.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalLabelText;

  /// No description provided for @paidLabelText.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paidLabelText;

  /// No description provided for @toPayLabelText.
  ///
  /// In en, this message translates to:
  /// **'To Pay'**
  String get toPayLabelText;

  /// No description provided for @couponCodeUsedLabelText.
  ///
  /// In en, this message translates to:
  /// **'Coupon code used'**
  String get couponCodeUsedLabelText;

  /// No description provided for @guestsText.
  ///
  /// In en, this message translates to:
  /// **'guest(s)'**
  String get guestsText;

  /// No description provided for @timesText.
  ///
  /// In en, this message translates to:
  /// **'time(s)'**
  String get timesText;

  /// No description provided for @onceText.
  ///
  /// In en, this message translates to:
  /// **'Once'**
  String get onceText;

  /// No description provided for @dailyText.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get dailyText;

  /// No description provided for @bookingDeletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Booking %d deleted'**
  String get bookingDeletedMessage;

  /// No description provided for @bookingLabelText.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get bookingLabelText;

  /// No description provided for @actionsTooltipText.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actionsTooltipText;

  /// No description provided for @errorText.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorText;

  /// No description provided for @reservationText.
  ///
  /// In en, this message translates to:
  /// **'Reservation'**
  String get reservationText;

  /// No description provided for @customerNoteText.
  ///
  /// In en, this message translates to:
  /// **'Customer Note'**
  String get customerNoteText;

  /// No description provided for @internalNotesText.
  ///
  /// In en, this message translates to:
  /// **'Internal Notes'**
  String get internalNotesText;

  /// No description provided for @customerInformationText.
  ///
  /// In en, this message translates to:
  /// **'Customer Information'**
  String get customerInformationText;

  /// No description provided for @firstnameLabelText.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstnameLabelText;

  /// No description provided for @lastnameLabelText.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastnameLabelText;

  /// No description provided for @emailLabelText.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabelText;

  /// No description provided for @phoneLabelText.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phoneLabelText;

  /// No description provided for @bookingCreatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Booking %d created'**
  String get bookingCreatedMessage;

  /// No description provided for @basePriceText.
  ///
  /// In en, this message translates to:
  /// **'Base price'**
  String get basePriceText;

  /// No description provided for @addBookingTitleText.
  ///
  /// In en, this message translates to:
  /// **'Add Booking'**
  String get addBookingTitleText;

  /// No description provided for @invalidRouteText.
  ///
  /// In en, this message translates to:
  /// **'Invalid route'**
  String get invalidRouteText;

  /// No description provided for @continueButtonText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButtonText;

  /// No description provided for @bookNowButtonText.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNowButtonText;

  /// No description provided for @quitButtonText.
  ///
  /// In en, this message translates to:
  /// **'Quit'**
  String get quitButtonText;

  /// No description provided for @checkInLabelText.
  ///
  /// In en, this message translates to:
  /// **'Check-In'**
  String get checkInLabelText;

  /// No description provided for @checkOutLabelText.
  ///
  /// In en, this message translates to:
  /// **'Check-Out'**
  String get checkOutLabelText;

  /// No description provided for @dateValidatorMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter date'**
  String get dateValidatorMessage;

  /// No description provided for @searchButtonText.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchButtonText;

  /// No description provided for @externalText.
  ///
  /// In en, this message translates to:
  /// **'External'**
  String get externalText;

  /// No description provided for @bookingConfirmedOptionText.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get bookingConfirmedOptionText;

  /// No description provided for @bookingCanceledOptionText.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get bookingCanceledOptionText;

  /// No description provided for @bookingAbandonedOptionText.
  ///
  /// In en, this message translates to:
  /// **'Abandoned'**
  String get bookingAbandonedOptionText;

  /// No description provided for @bookingPendingAdminOptionText.
  ///
  /// In en, this message translates to:
  /// **'Pending Admin'**
  String get bookingPendingAdminOptionText;

  /// No description provided for @bookingPendingUserOptionText.
  ///
  /// In en, this message translates to:
  /// **'Pending User'**
  String get bookingPendingUserOptionText;

  /// No description provided for @bookingPendingPaymentOptionText.
  ///
  /// In en, this message translates to:
  /// **'Pending Payment'**
  String get bookingPendingPaymentOptionText;

  /// No description provided for @todayOptionText.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayOptionText;

  /// No description provided for @thisWeekOptionText.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeekOptionText;

  /// No description provided for @thisMonthOptionText.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonthOptionText;

  /// No description provided for @filtersTitleText.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filtersTitleText;

  /// No description provided for @resetButtonText.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetButtonText;

  /// No description provided for @bookingStatusLabelText.
  ///
  /// In en, this message translates to:
  /// **'Booking Status'**
  String get bookingStatusLabelText;

  /// No description provided for @dateCreatedLabelText.
  ///
  /// In en, this message translates to:
  /// **'Date created'**
  String get dateCreatedLabelText;

  /// No description provided for @searchHintText.
  ///
  /// In en, this message translates to:
  /// **'search...'**
  String get searchHintText;

  /// No description provided for @displayExternalBookingsLabelText.
  ///
  /// In en, this message translates to:
  /// **'Display external bookings'**
  String get displayExternalBookingsLabelText;

  /// No description provided for @paymentCompletedOptionText.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get paymentCompletedOptionText;

  /// No description provided for @paymentCanceledOptionText.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get paymentCanceledOptionText;

  /// No description provided for @paymentAbandonedOptionText.
  ///
  /// In en, this message translates to:
  /// **'Abandoned'**
  String get paymentAbandonedOptionText;

  /// No description provided for @paymentPendingOptionText.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get paymentPendingOptionText;

  /// No description provided for @paymentFailedOptionText.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get paymentFailedOptionText;

  /// No description provided for @paymentRefundedOptionText.
  ///
  /// In en, this message translates to:
  /// **'Refunded'**
  String get paymentRefundedOptionText;

  /// No description provided for @paymentOnHoldOptionText.
  ///
  /// In en, this message translates to:
  /// **'On Hold'**
  String get paymentOnHoldOptionText;

  /// No description provided for @paymentStatusLabelText.
  ///
  /// In en, this message translates to:
  /// **'Payment Status'**
  String get paymentStatusLabelText;

  /// No description provided for @paymentSetToCompletedButtonText.
  ///
  /// In en, this message translates to:
  /// **'Set to Completed'**
  String get paymentSetToCompletedButtonText;

  /// No description provided for @paymentSetToCanceledButtonText.
  ///
  /// In en, this message translates to:
  /// **'Set to Canceled'**
  String get paymentSetToCanceledButtonText;

  /// No description provided for @paymentSetToOnHoldButtonText.
  ///
  /// In en, this message translates to:
  /// **'Set to On Hold'**
  String get paymentSetToOnHoldButtonText;

  /// No description provided for @paymentSetToPendingButtonText.
  ///
  /// In en, this message translates to:
  /// **'Set to Pending'**
  String get paymentSetToPendingButtonText;

  /// No description provided for @paymentSetToFailedButtonText.
  ///
  /// In en, this message translates to:
  /// **'Set to Failed'**
  String get paymentSetToFailedButtonText;

  /// No description provided for @paymentSetToRefundedButtonText.
  ///
  /// In en, this message translates to:
  /// **'Set to Refunded'**
  String get paymentSetToRefundedButtonText;

  /// No description provided for @paymentText.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get paymentText;

  /// No description provided for @calendarFormatMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get calendarFormatMonth;

  /// No description provided for @calendarFormatTwoWeeks.
  ///
  /// In en, this message translates to:
  /// **'2 weeks'**
  String get calendarFormatTwoWeeks;

  /// No description provided for @calendarFormatWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get calendarFormatWeek;

  /// Label for an optional customer field when creating a booking.
  ///
  /// In en, this message translates to:
  /// **'{label} (optional)'**
  String optionalFieldLabel(String label);

  /// No description provided for @bookingEmailHelpText.
  ///
  /// In en, this message translates to:
  /// **'Enter an email address if the guest should receive booking emails.'**
  String get bookingEmailHelpText;

  /// No description provided for @invalidCustomerEmailText.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get invalidCustomerEmailText;

  /// No description provided for @bookingStatusConfirmedText.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get bookingStatusConfirmedText;

  /// No description provided for @bookingStatusPendingText.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get bookingStatusPendingText;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es', 'fr', 'it', 'pl', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'it': return AppLocalizationsIt();
    case 'pl': return AppLocalizationsPl();
    case 'uk': return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
