import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';

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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('ko'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Laundry Dose'**
  String get appName;

  /// No description provided for @tabDose.
  ///
  /// In en, this message translates to:
  /// **'Wash'**
  String get tabDose;

  /// No description provided for @tabDetergents.
  ///
  /// In en, this message translates to:
  /// **'Shelf'**
  String get tabDetergents;

  /// No description provided for @tabHistory.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get tabHistory;

  /// No description provided for @tabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tabSettings;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Use the right amount.'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Body.
  ///
  /// In en, this message translates to:
  /// **'Save the dose printed on your detergent once, then stop re-reading the label every wash.'**
  String get onboarding1Body;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Dose in seconds.'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Body.
  ///
  /// In en, this message translates to:
  /// **'Pick only the things your label actually uses, like load size, soil level or water hardness.'**
  String get onboarding2Body;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'Your label. Your phone.'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Body.
  ///
  /// In en, this message translates to:
  /// **'No account or subscription. Your detergent settings, label photos and wash history stay on this iPhone.'**
  String get onboarding3Body;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get learnMore;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Laundry day'**
  String get homeTitle;

  /// No description provided for @chooseDetergent.
  ///
  /// In en, this message translates to:
  /// **'Choose detergent'**
  String get chooseDetergent;

  /// No description provided for @changeDetergent.
  ///
  /// In en, this message translates to:
  /// **'Change detergent'**
  String get changeDetergent;

  /// No description provided for @noDetergentTitle.
  ///
  /// In en, this message translates to:
  /// **'Add your detergent first'**
  String get noDetergentTitle;

  /// No description provided for @noDetergentBody.
  ///
  /// In en, this message translates to:
  /// **'Copy the dose from the package once. Laundry Dose will make it quick to find next time.'**
  String get noDetergentBody;

  /// No description provided for @addDetergent.
  ///
  /// In en, this message translates to:
  /// **'Add detergent'**
  String get addDetergent;

  /// No description provided for @recommendedDose.
  ///
  /// In en, this message translates to:
  /// **'YOUR LABEL DOSE'**
  String get recommendedDose;

  /// No description provided for @basedOnYourLabel.
  ///
  /// In en, this message translates to:
  /// **'From the label values you confirmed.'**
  String get basedOnYourLabel;

  /// No description provided for @costThisWash.
  ///
  /// In en, this message translates to:
  /// **'This wash'**
  String get costThisWash;

  /// No description provided for @logWash.
  ///
  /// In en, this message translates to:
  /// **'Save this wash'**
  String get logWash;

  /// No description provided for @washLogged.
  ///
  /// In en, this message translates to:
  /// **'Wash saved'**
  String get washLogged;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @missingRuleTitle.
  ///
  /// In en, this message translates to:
  /// **'Add this label value'**
  String get missingRuleTitle;

  /// No description provided for @missingRuleBody.
  ///
  /// In en, this message translates to:
  /// **'You have not saved a dose for this combination. Check the detergent package and add the printed value instead of guessing.'**
  String get missingRuleBody;

  /// No description provided for @addLabelValue.
  ///
  /// In en, this message translates to:
  /// **'Add label value'**
  String get addLabelValue;

  /// No description provided for @load.
  ///
  /// In en, this message translates to:
  /// **'Load'**
  String get load;

  /// No description provided for @soil.
  ///
  /// In en, this message translates to:
  /// **'Soil'**
  String get soil;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @machine.
  ///
  /// In en, this message translates to:
  /// **'Machine'**
  String get machine;

  /// No description provided for @small.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get small;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @large.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get large;

  /// No description provided for @extraLarge.
  ///
  /// In en, this message translates to:
  /// **'XL'**
  String get extraLarge;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @heavy.
  ///
  /// In en, this message translates to:
  /// **'Heavy'**
  String get heavy;

  /// No description provided for @soft.
  ///
  /// In en, this message translates to:
  /// **'Soft'**
  String get soft;

  /// No description provided for @hard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get hard;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'I don’t know'**
  String get unknown;

  /// No description provided for @anyMachine.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get anyMachine;

  /// No description provided for @heMachine.
  ///
  /// In en, this message translates to:
  /// **'HE'**
  String get heMachine;

  /// No description provided for @standardMachine.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get standardMachine;

  /// No description provided for @smallHelp.
  ///
  /// In en, this message translates to:
  /// **'About 1/3 drum'**
  String get smallHelp;

  /// No description provided for @mediumHelp.
  ///
  /// In en, this message translates to:
  /// **'About 1/2 drum'**
  String get mediumHelp;

  /// No description provided for @largeHelp.
  ///
  /// In en, this message translates to:
  /// **'About 3/4 drum'**
  String get largeHelp;

  /// No description provided for @xlHelp.
  ///
  /// In en, this message translates to:
  /// **'More than 3/4, within your washer’s loading limit'**
  String get xlHelp;

  /// No description provided for @loadHelpFootnote.
  ///
  /// In en, this message translates to:
  /// **'Drum fullness is only a visual shortcut. Follow your washer manual if it differs.'**
  String get loadHelpFootnote;

  /// No description provided for @unknownWaterHelp.
  ///
  /// In en, this message translates to:
  /// **'If you do not know your water hardness, this detergent uses the fallback row saved in its setup.'**
  String get unknownWaterHelp;

  /// No description provided for @mediumFallbackNote.
  ///
  /// In en, this message translates to:
  /// **'Unknown water hardness will use Medium because that row exists in this profile.'**
  String get mediumFallbackNote;

  /// No description provided for @detergentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Detergents'**
  String get detergentsTitle;

  /// No description provided for @detergentsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No detergents yet'**
  String get detergentsEmptyTitle;

  /// No description provided for @detergentsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add the detergent you actually use and copy its label dose.'**
  String get detergentsEmptyBody;

  /// No description provided for @defaultBadge.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultBadge;

  /// No description provided for @setAsDefault.
  ///
  /// In en, this message translates to:
  /// **'Set as default'**
  String get setAsDefault;

  /// No description provided for @duplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get duplicate;

  /// No description provided for @duplicateForAnotherMachine.
  ///
  /// In en, this message translates to:
  /// **'Duplicate for another machine'**
  String get duplicateForAnotherMachine;

  /// No description provided for @deleteDetergentTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this detergent?'**
  String get deleteDetergentTitle;

  /// No description provided for @deleteDetergentBody.
  ///
  /// In en, this message translates to:
  /// **'Its saved rules and label photo will be removed. Existing wash-history snapshots will remain.'**
  String get deleteDetergentBody;

  /// No description provided for @deleteDetergentConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete detergent'**
  String get deleteDetergentConfirm;

  /// No description provided for @addDetergentTitle.
  ///
  /// In en, this message translates to:
  /// **'Add detergent'**
  String get addDetergentTitle;

  /// No description provided for @editDetergentTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit detergent'**
  String get editDetergentTitle;

  /// No description provided for @quickSetup.
  ///
  /// In en, this message translates to:
  /// **'Quick setup'**
  String get quickSetup;

  /// No description provided for @advancedRules.
  ///
  /// In en, this message translates to:
  /// **'Advanced rules'**
  String get advancedRules;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Product name'**
  String get name;

  /// No description provided for @brandOptional.
  ///
  /// In en, this message translates to:
  /// **'Brand (optional)'**
  String get brandOptional;

  /// No description provided for @detergentNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Everyday liquid'**
  String get detergentNamePlaceholder;

  /// No description provided for @brandPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Brand name'**
  String get brandPlaceholder;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @liquid.
  ///
  /// In en, this message translates to:
  /// **'Liquid'**
  String get liquid;

  /// No description provided for @powder.
  ///
  /// In en, this message translates to:
  /// **'Powder'**
  String get powder;

  /// No description provided for @pods.
  ///
  /// In en, this message translates to:
  /// **'Pods'**
  String get pods;

  /// No description provided for @sheets.
  ///
  /// In en, this message translates to:
  /// **'Sheets'**
  String get sheets;

  /// No description provided for @labelPhoto.
  ///
  /// In en, this message translates to:
  /// **'Label photo'**
  String get labelPhoto;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add photo'**
  String get addPhoto;

  /// No description provided for @replacePhoto.
  ///
  /// In en, this message translates to:
  /// **'Replace photo'**
  String get replacePhoto;

  /// No description provided for @removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get removePhoto;

  /// No description provided for @photoStoredLocally.
  ///
  /// In en, this message translates to:
  /// **'The label photo stays in this app’s local storage.'**
  String get photoStoredLocally;

  /// No description provided for @doseSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Dose setup'**
  String get doseSetupTitle;

  /// No description provided for @copyFromPackage.
  ///
  /// In en, this message translates to:
  /// **'Copy these values from your detergent package.'**
  String get copyFromPackage;

  /// No description provided for @ruleStyle.
  ///
  /// In en, this message translates to:
  /// **'How is the label written?'**
  String get ruleStyle;

  /// No description provided for @oneStandardDose.
  ///
  /// In en, this message translates to:
  /// **'One standard dose'**
  String get oneStandardDose;

  /// No description provided for @byLoadSize.
  ///
  /// In en, this message translates to:
  /// **'Different doses by load size'**
  String get byLoadSize;

  /// No description provided for @simpleAdjustments.
  ///
  /// In en, this message translates to:
  /// **'Base dose + adjustments'**
  String get simpleAdjustments;

  /// No description provided for @fullTable.
  ///
  /// In en, this message translates to:
  /// **'Full table'**
  String get fullTable;

  /// No description provided for @baseDose.
  ///
  /// In en, this message translates to:
  /// **'Base dose'**
  String get baseDose;

  /// No description provided for @dose.
  ///
  /// In en, this message translates to:
  /// **'Dose'**
  String get dose;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// No description provided for @notListed.
  ///
  /// In en, this message translates to:
  /// **'Not listed on my label'**
  String get notListed;

  /// No description provided for @useOnlyPrintedValues.
  ///
  /// In en, this message translates to:
  /// **'Enter only values your detergent maker prints for this product.'**
  String get useOnlyPrintedValues;

  /// No description provided for @enableSoil.
  ///
  /// In en, this message translates to:
  /// **'My label changes the dose for soil level'**
  String get enableSoil;

  /// No description provided for @enableWater.
  ///
  /// In en, this message translates to:
  /// **'My label changes the dose for water hardness'**
  String get enableWater;

  /// No description provided for @machineVariant.
  ///
  /// In en, this message translates to:
  /// **'Which label instructions apply?'**
  String get machineVariant;

  /// No description provided for @machineVariantHelp.
  ///
  /// In en, this message translates to:
  /// **'Choose HE or Standard only if this product prints different instructions. Otherwise use Any.'**
  String get machineVariantHelp;

  /// No description provided for @soilAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Soil adjustment'**
  String get soilAdjustment;

  /// No description provided for @waterAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Water adjustment'**
  String get waterAdjustment;

  /// No description provided for @addToBase.
  ///
  /// In en, this message translates to:
  /// **'Change from base dose'**
  String get addToBase;

  /// No description provided for @customMatrix.
  ///
  /// In en, this message translates to:
  /// **'Custom label table'**
  String get customMatrix;

  /// No description provided for @matrixHelp.
  ///
  /// In en, this message translates to:
  /// **'Enter each combination exactly as printed. Missing cells stay unavailable; they are never guessed.'**
  String get matrixHelp;

  /// No description provided for @measurementTitle.
  ///
  /// In en, this message translates to:
  /// **'Cap & scoop markers'**
  String get measurementTitle;

  /// No description provided for @measurementBody.
  ///
  /// In en, this message translates to:
  /// **'Save the lines on your cap or scoop so the result can show a real-world marker.'**
  String get measurementBody;

  /// No description provided for @addMarker.
  ///
  /// In en, this message translates to:
  /// **'Add marker'**
  String get addMarker;

  /// No description provided for @markerName.
  ///
  /// In en, this message translates to:
  /// **'Marker name'**
  String get markerName;

  /// No description provided for @markerNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Cap line 2'**
  String get markerNamePlaceholder;

  /// No description provided for @markerAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount at this marker'**
  String get markerAmount;

  /// No description provided for @betweenMarkers.
  ///
  /// In en, this message translates to:
  /// **'Between {lower} and {upper}'**
  String betweenMarkers(String lower, String upper);

  /// No description provided for @nearMarker.
  ///
  /// In en, this message translates to:
  /// **'≈ {marker}'**
  String nearMarker(String marker);

  /// No description provided for @belowFirstMarker.
  ///
  /// In en, this message translates to:
  /// **'Below {marker}'**
  String belowFirstMarker(String marker);

  /// No description provided for @aboveLastMarker.
  ///
  /// In en, this message translates to:
  /// **'Above {marker}'**
  String aboveLastMarker(String marker);

  /// No description provided for @packageCostTitle.
  ///
  /// In en, this message translates to:
  /// **'Package & cost'**
  String get packageCostTitle;

  /// No description provided for @packageQuantity.
  ///
  /// In en, this message translates to:
  /// **'Package size'**
  String get packageQuantity;

  /// No description provided for @packagePrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get packagePrice;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @costOptionalHelp.
  ///
  /// In en, this message translates to:
  /// **'Optional. Used only to estimate cost per wash.'**
  String get costOptionalHelp;

  /// No description provided for @estimatedCost.
  ///
  /// In en, this message translates to:
  /// **'Estimated cost'**
  String get estimatedCost;

  /// No description provided for @costUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Add package price and size to see cost per wash.'**
  String get costUnavailable;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your journal'**
  String get historyTitle;

  /// No description provided for @historyEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No washes logged'**
  String get historyEmptyTitle;

  /// No description provided for @historyEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Logging is optional. Use “Log wash” after a result when you want a local record.'**
  String get historyEmptyBody;

  /// No description provided for @deleteLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this wash?'**
  String get deleteLogTitle;

  /// No description provided for @deleteLogBody.
  ///
  /// In en, this message translates to:
  /// **'This removes only this local history entry.'**
  String get deleteLogBody;

  /// No description provided for @deleteLogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete wash'**
  String get deleteLogConfirm;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @followSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow system'**
  String get followSystem;

  /// No description provided for @defaults.
  ///
  /// In en, this message translates to:
  /// **'Defaults'**
  String get defaults;

  /// No description provided for @defaultLoad.
  ///
  /// In en, this message translates to:
  /// **'Default load'**
  String get defaultLoad;

  /// No description provided for @defaultSoil.
  ///
  /// In en, this message translates to:
  /// **'Default soil'**
  String get defaultSoil;

  /// No description provided for @defaultWater.
  ///
  /// In en, this message translates to:
  /// **'Default water'**
  String get defaultWater;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @privacyChoices.
  ///
  /// In en, this message translates to:
  /// **'Privacy choices'**
  String get privacyChoices;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About Laundry Dose'**
  String get about;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacyTitle;

  /// No description provided for @privacyLocalTitle.
  ///
  /// In en, this message translates to:
  /// **'Your laundry data stays local'**
  String get privacyLocalTitle;

  /// No description provided for @privacyLocalBody.
  ///
  /// In en, this message translates to:
  /// **'Detergent profiles, dose rules, label photos and wash history are stored on this iPhone. Laundry Dose has no account or app backend.'**
  String get privacyLocalBody;

  /// No description provided for @privacyAdsTitle.
  ///
  /// In en, this message translates to:
  /// **'Ads are separate'**
  String get privacyAdsTitle;

  /// No description provided for @privacyAdsBody.
  ///
  /// In en, this message translates to:
  /// **'The free app uses Google AdMob. The advertising SDK may process device, advertising and diagnostic information according to your region and consent choices.'**
  String get privacyAdsBody;

  /// No description provided for @privacyNoSaleClaim.
  ///
  /// In en, this message translates to:
  /// **'Laundry Dose does not sell your detergent or wash-history data.'**
  String get privacyNoSaleClaim;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @manageConsent.
  ///
  /// In en, this message translates to:
  /// **'Manage ad privacy choices'**
  String get manageConsent;

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'How Laundry Dose works'**
  String get helpTitle;

  /// No description provided for @helpLabelFirstTitle.
  ///
  /// In en, this message translates to:
  /// **'Use your product label'**
  String get helpLabelFirstTitle;

  /// No description provided for @helpLabelFirstBody.
  ///
  /// In en, this message translates to:
  /// **'Laundry Dose is a personal label lookup, not a universal detergent prescription. Different products and markets can use different doses.'**
  String get helpLabelFirstBody;

  /// No description provided for @helpHardnessTitle.
  ///
  /// In en, this message translates to:
  /// **'Water hardness'**
  String get helpHardnessTitle;

  /// No description provided for @helpHardnessBody.
  ///
  /// In en, this message translates to:
  /// **'Only enable hardness rules when your detergent label provides them. Laundry Dose does not add a generic hard-water amount.'**
  String get helpHardnessBody;

  /// No description provided for @helpMachineTitle.
  ///
  /// In en, this message translates to:
  /// **'HE and standard washers'**
  String get helpMachineTitle;

  /// No description provided for @helpMachineBody.
  ///
  /// In en, this message translates to:
  /// **'If your product has separate HE and standard instructions, save the instructions that match your washer. Follow the washer and detergent manuals if they disagree with this app.'**
  String get helpMachineBody;

  /// No description provided for @helpPodsTitle.
  ///
  /// In en, this message translates to:
  /// **'Pods and sheets'**
  String get helpPodsTitle;

  /// No description provided for @helpPodsBody.
  ///
  /// In en, this message translates to:
  /// **'Enter the count printed for your product. Laundry Dose does not invent fractional pods.'**
  String get helpPodsBody;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Laundry Dose organizes values you enter from product labels. It does not guarantee cleaning results. Follow your detergent package, garment care label and washer manual when they differ.'**
  String get disclaimer;

  /// No description provided for @aboutBody.
  ///
  /// In en, this message translates to:
  /// **'A small offline-first utility for finding the dose printed on your own detergent label.'**
  String get aboutBody;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'No account'**
  String get noAccount;

  /// No description provided for @noSubscription.
  ///
  /// In en, this message translates to:
  /// **'No subscription'**
  String get noSubscription;

  /// No description provided for @offlineCore.
  ///
  /// In en, this message translates to:
  /// **'Core calculator works offline'**
  String get offlineCore;

  /// No description provided for @validationRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get validationRequired;

  /// No description provided for @validationNameTooLong.
  ///
  /// In en, this message translates to:
  /// **'Use 60 characters or fewer.'**
  String get validationNameTooLong;

  /// No description provided for @validationPositive.
  ///
  /// In en, this message translates to:
  /// **'Enter a value greater than zero.'**
  String get validationPositive;

  /// No description provided for @validationNonNegative.
  ///
  /// In en, this message translates to:
  /// **'Enter zero or a positive value.'**
  String get validationNonNegative;

  /// No description provided for @validationDoseOrder.
  ///
  /// In en, this message translates to:
  /// **'Check the label values. A smaller load is higher than a larger-load dose.'**
  String get validationDoseOrder;

  /// No description provided for @validationMarkerOrder.
  ///
  /// In en, this message translates to:
  /// **'Marker amounts must increase from one line to the next.'**
  String get validationMarkerOrder;

  /// No description provided for @validationDuplicateMarker.
  ///
  /// In en, this message translates to:
  /// **'Two markers cannot use the same amount.'**
  String get validationDuplicateMarker;

  /// No description provided for @validationWholePods.
  ///
  /// In en, this message translates to:
  /// **'Pods must be entered as whole counts.'**
  String get validationWholePods;

  /// No description provided for @validationHalfSheets.
  ///
  /// In en, this message translates to:
  /// **'Sheets must use 0.5 increments.'**
  String get validationHalfSheets;

  /// No description provided for @validationCurrency.
  ///
  /// In en, this message translates to:
  /// **'Choose a currency when you enter a price.'**
  String get validationCurrency;

  /// No description provided for @validationPackageQuantity.
  ///
  /// In en, this message translates to:
  /// **'Add a package size greater than zero to calculate cost.'**
  String get validationPackageQuantity;

  /// No description provided for @validationTooLarge.
  ///
  /// In en, this message translates to:
  /// **'That value looks unusually large. Check the unit and package label.'**
  String get validationTooLarge;

  /// No description provided for @errorGenericTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorGenericTitle;

  /// No description provided for @errorGenericBody.
  ///
  /// In en, this message translates to:
  /// **'Your saved laundry data was not changed. Try again.'**
  String get errorGenericBody;

  /// No description provided for @errorSaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t save'**
  String get errorSaveTitle;

  /// No description provided for @errorPhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t save photo'**
  String get errorPhotoTitle;

  /// No description provided for @errorAdIgnored.
  ///
  /// In en, this message translates to:
  /// **''**
  String get errorAdIgnored;

  /// No description provided for @offlineNotice.
  ///
  /// In en, this message translates to:
  /// **'You’re offline. Your calculator and history still work.'**
  String get offlineNotice;

  /// No description provided for @photoPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow photo access?'**
  String get photoPermissionTitle;

  /// No description provided for @photoPermissionBody.
  ///
  /// In en, this message translates to:
  /// **'Choose a label photo to store with this detergent. Laundry Dose only needs access to the photo you select.'**
  String get photoPermissionBody;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @unitMl.
  ///
  /// In en, this message translates to:
  /// **'mL'**
  String get unitMl;

  /// No description provided for @unitUsFlOz.
  ///
  /// In en, this message translates to:
  /// **'US fl oz'**
  String get unitUsFlOz;

  /// No description provided for @unitTbsp.
  ///
  /// In en, this message translates to:
  /// **'tbsp'**
  String get unitTbsp;

  /// No description provided for @unitTsp.
  ///
  /// In en, this message translates to:
  /// **'tsp'**
  String get unitTsp;

  /// No description provided for @unitG.
  ///
  /// In en, this message translates to:
  /// **'g'**
  String get unitG;

  /// No description provided for @unitOz.
  ///
  /// In en, this message translates to:
  /// **'oz'**
  String get unitOz;

  /// No description provided for @unitPod.
  ///
  /// In en, this message translates to:
  /// **'pod'**
  String get unitPod;

  /// No description provided for @unitPods.
  ///
  /// In en, this message translates to:
  /// **'pods'**
  String get unitPods;

  /// No description provided for @unitSheet.
  ///
  /// In en, this message translates to:
  /// **'sheet'**
  String get unitSheet;

  /// No description provided for @unitSheets.
  ///
  /// In en, this message translates to:
  /// **'sheets'**
  String get unitSheets;

  /// No description provided for @unitScoop.
  ///
  /// In en, this message translates to:
  /// **'scoop'**
  String get unitScoop;

  /// No description provided for @unitScoops.
  ///
  /// In en, this message translates to:
  /// **'scoops'**
  String get unitScoops;

  /// No description provided for @estimated.
  ///
  /// In en, this message translates to:
  /// **'Estimated'**
  String get estimated;

  /// No description provided for @estimatedRemaining.
  ///
  /// In en, this message translates to:
  /// **'Estimated remaining'**
  String get estimatedRemaining;

  /// No description provided for @estimatedWashesLeft.
  ///
  /// In en, this message translates to:
  /// **'About {count} washes left'**
  String estimatedWashesLeft(num count);

  /// No description provided for @remainingEstimateHelp.
  ///
  /// In en, this message translates to:
  /// **'An estimate based only on washes you log in this app.'**
  String get remainingEstimateHelp;

  /// No description provided for @setupComplete.
  ///
  /// In en, this message translates to:
  /// **'Detergent saved'**
  String get setupComplete;

  /// No description provided for @changesSaved.
  ///
  /// In en, this message translates to:
  /// **'Changes saved'**
  String get changesSaved;

  /// No description provided for @unsavedChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get unsavedChangesTitle;

  /// No description provided for @unsavedChangesBody.
  ///
  /// In en, this message translates to:
  /// **'Your edits have not been saved.'**
  String get unsavedChangesBody;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @units.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get units;

  /// No description provided for @unitSystemAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get unitSystemAuto;

  /// No description provided for @unitSystemMetric.
  ///
  /// In en, this message translates to:
  /// **'Metric'**
  String get unitSystemMetric;

  /// No description provided for @unitSystemUS.
  ///
  /// In en, this message translates to:
  /// **'US'**
  String get unitSystemUS;

  /// No description provided for @defaultWaterUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get defaultWaterUnknown;

  /// No description provided for @increase.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get increase;

  /// No description provided for @decrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get decrease;

  /// No description provided for @noChange.
  ///
  /// In en, this message translates to:
  /// **'No change'**
  String get noChange;

  /// No description provided for @checkLabelWarning.
  ///
  /// In en, this message translates to:
  /// **'This value looks unusual. Check the unit and product label.'**
  String get checkLabelWarning;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @photoLibrary.
  ///
  /// In en, this message translates to:
  /// **'Photo Library'**
  String get photoLibrary;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageKorean.
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get languageKorean;

  /// No description provided for @languageJapanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get languageJapanese;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get languageGerman;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get languageFrench;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get selectLanguage;

  /// No description provided for @currentDetergent.
  ///
  /// In en, this message translates to:
  /// **'DETERGENT'**
  String get currentDetergent;

  /// No description provided for @reduceMotion.
  ///
  /// In en, this message translates to:
  /// **'Reduce motion'**
  String get reduceMotion;

  /// No description provided for @reduceMotionHelp.
  ///
  /// In en, this message translates to:
  /// **'Also respects the iPhone Reduce Motion setting.'**
  String get reduceMotionHelp;

  /// No description provided for @selectAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Choose adjustment'**
  String get selectAdjustment;

  /// No description provided for @helpLoadTitle.
  ///
  /// In en, this message translates to:
  /// **'Load size guide'**
  String get helpLoadTitle;

  /// No description provided for @helpLoadBody.
  ///
  /// In en, this message translates to:
  /// **'Use drum fullness only as a rough visual cue. Small ≈ 1/3, Medium ≈ 1/2, Large ≈ 3/4. Washer designs vary, so follow your machine manual when it differs.'**
  String get helpLoadBody;

  /// No description provided for @helpMarkersTitle.
  ///
  /// In en, this message translates to:
  /// **'Cap and scoop markers'**
  String get helpMarkersTitle;

  /// No description provided for @helpMarkersBody.
  ///
  /// In en, this message translates to:
  /// **'Save the markings from your own cap or scoop once. Laundry Dose only maps a result to the markings you entered.'**
  String get helpMarkersBody;

  /// No description provided for @helpCostTitle.
  ///
  /// In en, this message translates to:
  /// **'Cost per wash'**
  String get helpCostTitle;

  /// No description provided for @helpCostBody.
  ///
  /// In en, this message translates to:
  /// **'If you add package quantity and price, Laundry Dose estimates the cost of the saved dose. It is an estimate, not a receipt or price tracker.'**
  String get helpCostBody;

  /// No description provided for @helpOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'Offline use'**
  String get helpOfflineTitle;

  /// No description provided for @helpOfflineBody.
  ///
  /// In en, this message translates to:
  /// **'Detergent profiles, label photos and wash history stay on this iPhone and core dosing works offline. Ads, consent updates and external links may require internet.'**
  String get helpOfflineBody;

  /// No description provided for @supportEmailAction.
  ///
  /// In en, this message translates to:
  /// **'Email support'**
  String get supportEmailAction;

  /// No description provided for @licenses.
  ///
  /// In en, this message translates to:
  /// **'Open-source licenses'**
  String get licenses;

  /// No description provided for @invalidProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Check this detergent profile'**
  String get invalidProfileTitle;

  /// No description provided for @invalidProfileBody.
  ///
  /// In en, this message translates to:
  /// **'A saved dose or unit is invalid. Open this detergent and compare the values with the product label before using the result.'**
  String get invalidProfileBody;

  /// No description provided for @reviewProfile.
  ///
  /// In en, this message translates to:
  /// **'Review profile'**
  String get reviewProfile;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'A little less guesswork.\nA better laundry day.'**
  String get welcomeTitle;

  /// No description provided for @welcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Read your detergent label once. Keep the right amount close at hand, every wash.'**
  String get welcomeBody;

  /// No description provided for @scanLabel.
  ///
  /// In en, this message translates to:
  /// **'Scan a label'**
  String get scanLabel;

  /// No description provided for @enterManually.
  ///
  /// In en, this message translates to:
  /// **'Enter manually'**
  String get enterManually;

  /// No description provided for @localScanNote.
  ///
  /// In en, this message translates to:
  /// **'Label reading happens on your iPhone. English labels supported.'**
  String get localScanNote;

  /// No description provided for @scanTitle.
  ///
  /// In en, this message translates to:
  /// **'Read the dosing instructions'**
  String get scanTitle;

  /// No description provided for @scanBody.
  ///
  /// In en, this message translates to:
  /// **'Photograph the directions on the back, straight on and in good light. Keep the amount and its load size in the same picture.'**
  String get scanBody;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takePhoto;

  /// No description provided for @choosePhoto.
  ///
  /// In en, this message translates to:
  /// **'Choose a photo'**
  String get choosePhoto;

  /// No description provided for @readingLabel.
  ///
  /// In en, this message translates to:
  /// **'Reading the label…'**
  String get readingLabel;

  /// No description provided for @reviewScan.
  ///
  /// In en, this message translates to:
  /// **'Check what we read'**
  String get reviewScan;

  /// No description provided for @scanReviewBody.
  ///
  /// In en, this message translates to:
  /// **'Compare each number with your package. You can edit it on the next screen. Nothing is saved yet.'**
  String get scanReviewBody;

  /// No description provided for @scanNoValues.
  ///
  /// In en, this message translates to:
  /// **'No clear dose found. You can still enter the instructions yourself.'**
  String get scanNoValues;

  /// No description provided for @scanFailed.
  ///
  /// In en, this message translates to:
  /// **'We couldn’t read this photo. Try again in better light, or enter the label manually.'**
  String get scanFailed;

  /// No description provided for @scanUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Label reading is available on iPhone. Manual setup works here.'**
  String get scanUnavailable;

  /// No description provided for @continueReview.
  ///
  /// In en, this message translates to:
  /// **'Review & finish setup'**
  String get continueReview;

  /// No description provided for @readText.
  ///
  /// In en, this message translates to:
  /// **'Text from the photo'**
  String get readText;

  /// No description provided for @forThisLoad.
  ///
  /// In en, this message translates to:
  /// **'For this load'**
  String get forThisLoad;

  /// No description provided for @washSubtitle.
  ///
  /// In en, this message translates to:
  /// **'One less thing to think about.'**
  String get washSubtitle;

  /// No description provided for @loadSize.
  ///
  /// In en, this message translates to:
  /// **'Load size'**
  String get loadSize;

  /// No description provided for @yourShelf.
  ///
  /// In en, this message translates to:
  /// **'Your shelf'**
  String get yourShelf;

  /// No description provided for @shelfSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The products you use, ready for next time.'**
  String get shelfSubtitle;

  /// No description provided for @historySubtitle.
  ///
  /// In en, this message translates to:
  /// **'A small record of laundry day.'**
  String get historySubtitle;

  /// No description provided for @savedWashes.
  ///
  /// In en, this message translates to:
  /// **'Washes recorded'**
  String get savedWashes;

  /// No description provided for @firstDetergent.
  ///
  /// In en, this message translates to:
  /// **'Start with your detergent'**
  String get firstDetergent;

  /// No description provided for @loadVisualNote.
  ///
  /// In en, this message translates to:
  /// **'Drum fullness is a visual guide. Follow your washer’s loading instructions.'**
  String get loadVisualNote;

  /// No description provided for @scanEvidence.
  ///
  /// In en, this message translates to:
  /// **'Read from your label'**
  String get scanEvidence;

  /// No description provided for @scanUnitNote.
  ///
  /// In en, this message translates to:
  /// **'Only clearly labeled amounts are filled in. Missing values stay blank.'**
  String get scanUnitNote;

  /// No description provided for @useForWash.
  ///
  /// In en, this message translates to:
  /// **'Use for this wash'**
  String get useForWash;

  /// No description provided for @standardDoseLoadHelp.
  ///
  /// In en, this message translates to:
  /// **'One amount is saved for this detergent. To choose Small, Medium or Large, add the amounts listed for each load size on your label.'**
  String get standardDoseLoadHelp;

  /// No description provided for @addLoadSizeAmounts.
  ///
  /// In en, this message translates to:
  /// **'Add load-size amounts'**
  String get addLoadSizeAmounts;
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
    'de',
    'en',
    'es',
    'fr',
    'ja',
    'ko',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
