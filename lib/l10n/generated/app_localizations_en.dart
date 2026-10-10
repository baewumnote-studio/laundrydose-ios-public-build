// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Laundry Dose';

  @override
  String get tabDose => 'Wash';

  @override
  String get tabDetergents => 'Shelf';

  @override
  String get tabHistory => 'Journal';

  @override
  String get tabSettings => 'Settings';

  @override
  String get onboarding1Title => 'Use the right amount.';

  @override
  String get onboarding1Body =>
      'Save the dose printed on your detergent once, then stop re-reading the label every wash.';

  @override
  String get onboarding2Title => 'Dose in seconds.';

  @override
  String get onboarding2Body =>
      'Pick only the things your label actually uses, like load size, soil level or water hardness.';

  @override
  String get onboarding3Title => 'Your label. Your phone.';

  @override
  String get onboarding3Body =>
      'No account or subscription. Your detergent settings, label photos and wash history stay on this iPhone.';

  @override
  String get getStarted => 'Get started';

  @override
  String get continueLabel => 'Continue';

  @override
  String get skip => 'Skip';

  @override
  String get done => 'Done';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get back => 'Back';

  @override
  String get close => 'Close';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get retry => 'Try again';

  @override
  String get learnMore => 'Learn more';

  @override
  String get notNow => 'Not now';

  @override
  String get homeTitle => 'Laundry day';

  @override
  String get chooseDetergent => 'Choose detergent';

  @override
  String get changeDetergent => 'Change detergent';

  @override
  String get noDetergentTitle => 'Add your detergent first';

  @override
  String get noDetergentBody =>
      'Copy the dose from the package once. Laundry Dose will make it quick to find next time.';

  @override
  String get addDetergent => 'Add detergent';

  @override
  String get recommendedDose => 'YOUR LABEL DOSE';

  @override
  String get basedOnYourLabel => 'From the label values you confirmed.';

  @override
  String get costThisWash => 'This wash';

  @override
  String get logWash => 'Save this wash';

  @override
  String get washLogged => 'Wash saved';

  @override
  String get undo => 'Undo';

  @override
  String get missingRuleTitle => 'Add this label value';

  @override
  String get missingRuleBody =>
      'You have not saved a dose for this combination. Check the detergent package and add the printed value instead of guessing.';

  @override
  String get addLabelValue => 'Add label value';

  @override
  String get load => 'Load';

  @override
  String get soil => 'Soil';

  @override
  String get water => 'Water';

  @override
  String get machine => 'Machine';

  @override
  String get small => 'Small';

  @override
  String get medium => 'Medium';

  @override
  String get large => 'Large';

  @override
  String get extraLarge => 'XL';

  @override
  String get light => 'Light';

  @override
  String get normal => 'Normal';

  @override
  String get heavy => 'Heavy';

  @override
  String get soft => 'Soft';

  @override
  String get hard => 'Hard';

  @override
  String get unknown => 'I don’t know';

  @override
  String get anyMachine => 'Any';

  @override
  String get heMachine => 'HE';

  @override
  String get standardMachine => 'Standard';

  @override
  String get smallHelp => 'About 1/3 drum';

  @override
  String get mediumHelp => 'About 1/2 drum';

  @override
  String get largeHelp => 'About 3/4 drum';

  @override
  String get xlHelp => 'More than 3/4, within your washer’s loading limit';

  @override
  String get loadHelpFootnote =>
      'Drum fullness is only a visual shortcut. Follow your washer manual if it differs.';

  @override
  String get unknownWaterHelp =>
      'If you do not know your water hardness, this detergent uses the fallback row saved in its setup.';

  @override
  String get mediumFallbackNote =>
      'Unknown water hardness will use Medium because that row exists in this profile.';

  @override
  String get detergentsTitle => 'Detergents';

  @override
  String get detergentsEmptyTitle => 'No detergents yet';

  @override
  String get detergentsEmptyBody =>
      'Add the detergent you actually use and copy its label dose.';

  @override
  String get defaultBadge => 'Default';

  @override
  String get setAsDefault => 'Set as default';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get duplicateForAnotherMachine => 'Duplicate for another machine';

  @override
  String get deleteDetergentTitle => 'Delete this detergent?';

  @override
  String get deleteDetergentBody =>
      'Its saved rules and label photo will be removed. Existing wash-history snapshots will remain.';

  @override
  String get deleteDetergentConfirm => 'Delete detergent';

  @override
  String get addDetergentTitle => 'Add detergent';

  @override
  String get editDetergentTitle => 'Edit detergent';

  @override
  String get quickSetup => 'Quick setup';

  @override
  String get advancedRules => 'Advanced rules';

  @override
  String get name => 'Product name';

  @override
  String get brandOptional => 'Brand (optional)';

  @override
  String get detergentNamePlaceholder => 'e.g. Everyday liquid';

  @override
  String get brandPlaceholder => 'e.g. Brand name';

  @override
  String get type => 'Type';

  @override
  String get liquid => 'Liquid';

  @override
  String get powder => 'Powder';

  @override
  String get pods => 'Pods';

  @override
  String get sheets => 'Sheets';

  @override
  String get labelPhoto => 'Label photo';

  @override
  String get addPhoto => 'Add photo';

  @override
  String get replacePhoto => 'Replace photo';

  @override
  String get removePhoto => 'Remove photo';

  @override
  String get photoStoredLocally =>
      'The label photo stays in this app’s local storage.';

  @override
  String get doseSetupTitle => 'Dose setup';

  @override
  String get copyFromPackage =>
      'Copy these values from your detergent package.';

  @override
  String get ruleStyle => 'How is the label written?';

  @override
  String get oneStandardDose => 'One standard dose';

  @override
  String get byLoadSize => 'Different doses by load size';

  @override
  String get simpleAdjustments => 'Base dose + adjustments';

  @override
  String get fullTable => 'Full table';

  @override
  String get baseDose => 'Base dose';

  @override
  String get dose => 'Dose';

  @override
  String get amount => 'Amount';

  @override
  String get unit => 'Unit';

  @override
  String get notListed => 'Not listed on my label';

  @override
  String get useOnlyPrintedValues =>
      'Enter only values your detergent maker prints for this product.';

  @override
  String get enableSoil => 'My label changes the dose for soil level';

  @override
  String get enableWater => 'My label changes the dose for water hardness';

  @override
  String get machineVariant => 'Which label instructions apply?';

  @override
  String get machineVariantHelp =>
      'Choose HE or Standard only if this product prints different instructions. Otherwise use Any.';

  @override
  String get soilAdjustment => 'Soil adjustment';

  @override
  String get waterAdjustment => 'Water adjustment';

  @override
  String get addToBase => 'Change from base dose';

  @override
  String get customMatrix => 'Custom label table';

  @override
  String get matrixHelp =>
      'Enter each combination exactly as printed. Missing cells stay unavailable; they are never guessed.';

  @override
  String get measurementTitle => 'Cap & scoop markers';

  @override
  String get measurementBody =>
      'Save the lines on your cap or scoop so the result can show a real-world marker.';

  @override
  String get addMarker => 'Add marker';

  @override
  String get markerName => 'Marker name';

  @override
  String get markerNamePlaceholder => 'e.g. Cap line 2';

  @override
  String get markerAmount => 'Amount at this marker';

  @override
  String betweenMarkers(String lower, String upper) {
    return 'Between $lower and $upper';
  }

  @override
  String nearMarker(String marker) {
    return '≈ $marker';
  }

  @override
  String belowFirstMarker(String marker) {
    return 'Below $marker';
  }

  @override
  String aboveLastMarker(String marker) {
    return 'Above $marker';
  }

  @override
  String get packageCostTitle => 'Package & cost';

  @override
  String get packageQuantity => 'Package size';

  @override
  String get packagePrice => 'Price';

  @override
  String get currency => 'Currency';

  @override
  String get costOptionalHelp =>
      'Optional. Used only to estimate cost per wash.';

  @override
  String get estimatedCost => 'Estimated cost';

  @override
  String get costUnavailable =>
      'Add package price and size to see cost per wash.';

  @override
  String get historyTitle => 'Your journal';

  @override
  String get historyEmptyTitle => 'No washes logged';

  @override
  String get historyEmptyBody =>
      'Logging is optional. Use “Log wash” after a result when you want a local record.';

  @override
  String get deleteLogTitle => 'Delete this wash?';

  @override
  String get deleteLogBody => 'This removes only this local history entry.';

  @override
  String get deleteLogConfirm => 'Delete wash';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get system => 'System';

  @override
  String get dark => 'Dark';

  @override
  String get language => 'Language';

  @override
  String get followSystem => 'Follow system';

  @override
  String get defaults => 'Defaults';

  @override
  String get defaultLoad => 'Default load';

  @override
  String get defaultSoil => 'Default soil';

  @override
  String get defaultWater => 'Default water';

  @override
  String get privacy => 'Privacy';

  @override
  String get privacyChoices => 'Privacy choices';

  @override
  String get about => 'About Laundry Dose';

  @override
  String get help => 'Help';

  @override
  String get version => 'Version';

  @override
  String get privacyTitle => 'Privacy';

  @override
  String get privacyLocalTitle => 'Your laundry data stays local';

  @override
  String get privacyLocalBody =>
      'Detergent profiles, dose rules, label photos and wash history are stored on this iPhone. Laundry Dose has no account or app backend.';

  @override
  String get privacyAdsTitle => 'Ads are separate';

  @override
  String get privacyAdsBody =>
      'The free app uses Google AdMob. The advertising SDK may process device, advertising and diagnostic information according to your region and consent choices.';

  @override
  String get privacyNoSaleClaim =>
      'Laundry Dose does not sell your detergent or wash-history data.';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get manageConsent => 'Manage ad privacy choices';

  @override
  String get helpTitle => 'How Laundry Dose works';

  @override
  String get helpLabelFirstTitle => 'Use your product label';

  @override
  String get helpLabelFirstBody =>
      'Laundry Dose is a personal label lookup, not a universal detergent prescription. Different products and markets can use different doses.';

  @override
  String get helpHardnessTitle => 'Water hardness';

  @override
  String get helpHardnessBody =>
      'Only enable hardness rules when your detergent label provides them. Laundry Dose does not add a generic hard-water amount.';

  @override
  String get helpMachineTitle => 'HE and standard washers';

  @override
  String get helpMachineBody =>
      'If your product has separate HE and standard instructions, save the instructions that match your washer. Follow the washer and detergent manuals if they disagree with this app.';

  @override
  String get helpPodsTitle => 'Pods and sheets';

  @override
  String get helpPodsBody =>
      'Enter the count printed for your product. Laundry Dose does not invent fractional pods.';

  @override
  String get disclaimer =>
      'Laundry Dose organizes values you enter from product labels. It does not guarantee cleaning results. Follow your detergent package, garment care label and washer manual when they differ.';

  @override
  String get aboutBody =>
      'A small offline-first utility for finding the dose printed on your own detergent label.';

  @override
  String get noAccount => 'No account';

  @override
  String get noSubscription => 'No subscription';

  @override
  String get offlineCore => 'Core calculator works offline';

  @override
  String get validationRequired => 'This field is required.';

  @override
  String get validationNameTooLong => 'Use 60 characters or fewer.';

  @override
  String get validationPositive => 'Enter a value greater than zero.';

  @override
  String get validationNonNegative => 'Enter zero or a positive value.';

  @override
  String get validationDoseOrder =>
      'Check the label values. A smaller load is higher than a larger-load dose.';

  @override
  String get validationMarkerOrder =>
      'Marker amounts must increase from one line to the next.';

  @override
  String get validationDuplicateMarker =>
      'Two markers cannot use the same amount.';

  @override
  String get validationWholePods => 'Pods must be entered as whole counts.';

  @override
  String get validationHalfSheets => 'Sheets must use 0.5 increments.';

  @override
  String get validationCurrency => 'Choose a currency when you enter a price.';

  @override
  String get validationPackageQuantity =>
      'Add a package size greater than zero to calculate cost.';

  @override
  String get validationTooLarge =>
      'That value looks unusually large. Check the unit and package label.';

  @override
  String get errorGenericTitle => 'Something went wrong';

  @override
  String get errorGenericBody =>
      'Your saved laundry data was not changed. Try again.';

  @override
  String get errorSaveTitle => 'Couldn’t save';

  @override
  String get errorPhotoTitle => 'Couldn’t save photo';

  @override
  String get errorAdIgnored => '';

  @override
  String get offlineNotice =>
      'You’re offline. Your calculator and history still work.';

  @override
  String get photoPermissionTitle => 'Allow photo access?';

  @override
  String get photoPermissionBody =>
      'Choose a label photo to store with this detergent. Laundry Dose only needs access to the photo you select.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get unitMl => 'mL';

  @override
  String get unitUsFlOz => 'US fl oz';

  @override
  String get unitTbsp => 'tbsp';

  @override
  String get unitTsp => 'tsp';

  @override
  String get unitG => 'g';

  @override
  String get unitOz => 'oz';

  @override
  String get unitPod => 'pod';

  @override
  String get unitPods => 'pods';

  @override
  String get unitSheet => 'sheet';

  @override
  String get unitSheets => 'sheets';

  @override
  String get unitScoop => 'scoop';

  @override
  String get unitScoops => 'scoops';

  @override
  String get estimated => 'Estimated';

  @override
  String get estimatedRemaining => 'Estimated remaining';

  @override
  String estimatedWashesLeft(num count) {
    return 'About $count washes left';
  }

  @override
  String get remainingEstimateHelp =>
      'An estimate based only on washes you log in this app.';

  @override
  String get setupComplete => 'Detergent saved';

  @override
  String get changesSaved => 'Changes saved';

  @override
  String get unsavedChangesTitle => 'Discard changes?';

  @override
  String get unsavedChangesBody => 'Your edits have not been saved.';

  @override
  String get discard => 'Discard';

  @override
  String get themeLight => 'Light';

  @override
  String get units => 'Units';

  @override
  String get unitSystemAuto => 'Auto';

  @override
  String get unitSystemMetric => 'Metric';

  @override
  String get unitSystemUS => 'US';

  @override
  String get defaultWaterUnknown => 'Unknown';

  @override
  String get increase => 'Increase';

  @override
  String get decrease => 'Decrease';

  @override
  String get noChange => 'No change';

  @override
  String get checkLabelWarning =>
      'This value looks unusual. Check the unit and product label.';

  @override
  String get camera => 'Camera';

  @override
  String get photoLibrary => 'Photo Library';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageKorean => 'Korean';

  @override
  String get languageJapanese => 'Japanese';

  @override
  String get languageGerman => 'German';

  @override
  String get languageFrench => 'French';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get selectLanguage => 'Select language';

  @override
  String get currentDetergent => 'DETERGENT';

  @override
  String get reduceMotion => 'Reduce motion';

  @override
  String get reduceMotionHelp =>
      'Also respects the iPhone Reduce Motion setting.';

  @override
  String get selectAdjustment => 'Choose adjustment';

  @override
  String get helpLoadTitle => 'Load size guide';

  @override
  String get helpLoadBody =>
      'Use drum fullness only as a rough visual cue. Small ≈ 1/3, Medium ≈ 1/2, Large ≈ 3/4. Washer designs vary, so follow your machine manual when it differs.';

  @override
  String get helpMarkersTitle => 'Cap and scoop markers';

  @override
  String get helpMarkersBody =>
      'Save the markings from your own cap or scoop once. Laundry Dose only maps a result to the markings you entered.';

  @override
  String get helpCostTitle => 'Cost per wash';

  @override
  String get helpCostBody =>
      'If you add package quantity and price, Laundry Dose estimates the cost of the saved dose. It is an estimate, not a receipt or price tracker.';

  @override
  String get helpOfflineTitle => 'Offline use';

  @override
  String get helpOfflineBody =>
      'Detergent profiles, label photos and wash history stay on this iPhone and core dosing works offline. Ads, consent updates and external links may require internet.';

  @override
  String get supportEmailAction => 'Email support';

  @override
  String get licenses => 'Open-source licenses';

  @override
  String get invalidProfileTitle => 'Check this detergent profile';

  @override
  String get invalidProfileBody =>
      'A saved dose or unit is invalid. Open this detergent and compare the values with the product label before using the result.';

  @override
  String get reviewProfile => 'Review profile';

  @override
  String get welcomeTitle => 'A little less guesswork.\nA better laundry day.';

  @override
  String get welcomeBody =>
      'Read your detergent label once. Keep the right amount close at hand, every wash.';

  @override
  String get scanLabel => 'Scan a label';

  @override
  String get enterManually => 'Enter manually';

  @override
  String get localScanNote =>
      'Label reading happens on your iPhone. English labels supported.';

  @override
  String get scanTitle => 'Read the dosing instructions';

  @override
  String get scanBody =>
      'Photograph the directions on the back, straight on and in good light. Keep the amount and its load size in the same picture.';

  @override
  String get takePhoto => 'Take a photo';

  @override
  String get choosePhoto => 'Choose a photo';

  @override
  String get readingLabel => 'Reading the label…';

  @override
  String get reviewScan => 'Check what we read';

  @override
  String get scanReviewBody =>
      'Compare each number with your package. You can edit it on the next screen. Nothing is saved yet.';

  @override
  String get scanNoValues =>
      'No clear dose found. You can still enter the instructions yourself.';

  @override
  String get scanFailed =>
      'We couldn’t read this photo. Try again in better light, or enter the label manually.';

  @override
  String get scanUnavailable =>
      'Label reading is available on iPhone. Manual setup works here.';

  @override
  String get continueReview => 'Review & finish setup';

  @override
  String get readText => 'Text from the photo';

  @override
  String get forThisLoad => 'For this load';

  @override
  String get washSubtitle => 'One less thing to think about.';

  @override
  String get loadSize => 'Load size';

  @override
  String get yourShelf => 'Your shelf';

  @override
  String get shelfSubtitle => 'The products you use, ready for next time.';

  @override
  String get historySubtitle => 'A small record of laundry day.';

  @override
  String get savedWashes => 'Washes recorded';

  @override
  String get firstDetergent => 'Start with your detergent';

  @override
  String get loadVisualNote =>
      'Drum fullness is a visual guide. Follow your washer’s loading instructions.';

  @override
  String get scanEvidence => 'Read from your label';

  @override
  String get scanUnitNote =>
      'Only clearly labeled amounts are filled in. Missing values stay blank.';

  @override
  String get useForWash => 'Use for this wash';

  @override
  String get standardDoseLoadHelp =>
      'One amount is saved for this detergent. To choose Small, Medium or Large, add the amounts listed for each load size on your label.';

  @override
  String get addLoadSizeAmounts => 'Add load-size amounts';
}
