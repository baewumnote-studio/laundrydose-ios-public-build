// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appName => 'Laundry Dose';

  @override
  String get tabDose => '용량';

  @override
  String get tabDetergents => '세제';

  @override
  String get tabHistory => '기록';

  @override
  String get tabSettings => '설정';

  @override
  String get onboarding1Title => '알맞은 양을 사용하세요.';

  @override
  String get onboarding1Body =>
      '세제 라벨에 적힌 사용량을 한 번 저장하면, 빨래할 때마다 다시 읽지 않아도 됩니다.';

  @override
  String get onboarding2Title => '몇 초 만에 확인하세요.';

  @override
  String get onboarding2Body => '세탁물 양, 오염도, 물 경도처럼 내 세제 라벨에 실제로 있는 항목만 고르세요.';

  @override
  String get onboarding3Title => '내 라벨. 내 아이폰.';

  @override
  String get onboarding3Body =>
      '계정도 구독도 없습니다. 세제 설정, 라벨 사진, 세탁 기록은 이 iPhone에 저장됩니다.';

  @override
  String get getStarted => '시작하기';

  @override
  String get continueLabel => '계속';

  @override
  String get skip => '건너뛰기';

  @override
  String get done => '완료';

  @override
  String get save => '저장';

  @override
  String get cancel => '취소';

  @override
  String get back => '뒤로';

  @override
  String get close => '닫기';

  @override
  String get edit => '편집';

  @override
  String get delete => '삭제';

  @override
  String get retry => '다시 시도';

  @override
  String get learnMore => '자세히 보기';

  @override
  String get notNow => '나중에';

  @override
  String get homeTitle => '오늘 세탁';

  @override
  String get chooseDetergent => '세제 선택';

  @override
  String get changeDetergent => '세제 변경';

  @override
  String get noDetergentTitle => '먼저 세제를 추가하세요';

  @override
  String get noDetergentBody => '제품 라벨의 사용량을 한 번 입력해 두면 다음부터 빠르게 확인할 수 있습니다.';

  @override
  String get addDetergent => '세제 추가';

  @override
  String get recommendedDose => '라벨 사용량';

  @override
  String get basedOnYourLabel => '이 제품 라벨에서 저장한 값을 기준으로 합니다.';

  @override
  String get costThisWash => '이번 세탁';

  @override
  String get logWash => '세탁 기록';

  @override
  String get washLogged => '세탁을 기록했어요';

  @override
  String get undo => '실행 취소';

  @override
  String get missingRuleTitle => '이 라벨 값을 추가하세요';

  @override
  String get missingRuleBody =>
      '이 조합의 사용량이 저장되어 있지 않습니다. 추측하지 말고 세제 포장에서 표시값을 확인해 추가하세요.';

  @override
  String get addLabelValue => '라벨 값 추가';

  @override
  String get load => '세탁물 양';

  @override
  String get soil => '오염도';

  @override
  String get water => '물 경도';

  @override
  String get machine => '세탁기';

  @override
  String get small => '적음';

  @override
  String get medium => '보통';

  @override
  String get large => '많음';

  @override
  String get extraLarge => '매우 많음';

  @override
  String get light => '가벼움';

  @override
  String get normal => '보통';

  @override
  String get heavy => '심함';

  @override
  String get soft => '연수';

  @override
  String get hard => '경수';

  @override
  String get unknown => '잘 모르겠어요';

  @override
  String get anyMachine => '구분 없음';

  @override
  String get heMachine => 'HE';

  @override
  String get standardMachine => '일반형';

  @override
  String get smallHelp => '드럼의 약 1/3';

  @override
  String get mediumHelp => '드럼의 약 1/2';

  @override
  String get largeHelp => '드럼의 약 3/4';

  @override
  String get xlHelp => '3/4 초과, 세탁기 허용 범위 안';

  @override
  String get loadHelpFootnote =>
      '드럼 채움 정도는 시각적 참고일 뿐입니다. 세탁기 설명이 다르면 설명서를 따르세요.';

  @override
  String get unknownWaterHelp => '물 경도를 모르면 이 세제 설정에 저장한 기본 행을 사용합니다.';

  @override
  String get mediumFallbackNote =>
      '이 프로필에 보통 경도 행이 있으므로 ‘잘 모르겠어요’는 보통 값을 사용합니다.';

  @override
  String get detergentsTitle => '세제';

  @override
  String get detergentsEmptyTitle => '등록된 세제가 없습니다';

  @override
  String get detergentsEmptyBody => '실제로 사용하는 세제를 추가하고 라벨의 사용량을 입력하세요.';

  @override
  String get defaultBadge => '기본';

  @override
  String get setAsDefault => '기본 세제로 설정';

  @override
  String get duplicate => '복제';

  @override
  String get duplicateForAnotherMachine => '다른 세탁기용으로 복제';

  @override
  String get deleteDetergentTitle => '이 세제를 삭제할까요?';

  @override
  String get deleteDetergentBody =>
      '저장된 규칙과 라벨 사진이 삭제됩니다. 기존 세탁 기록의 스냅샷은 남습니다.';

  @override
  String get deleteDetergentConfirm => '세제 삭제';

  @override
  String get addDetergentTitle => '세제 추가';

  @override
  String get editDetergentTitle => '세제 편집';

  @override
  String get quickSetup => '빠른 설정';

  @override
  String get advancedRules => '고급 규칙';

  @override
  String get name => '이름';

  @override
  String get brandOptional => '브랜드(선택)';

  @override
  String get detergentNamePlaceholder => '예: 매일 쓰는 액체세제';

  @override
  String get brandPlaceholder => '예: 브랜드명';

  @override
  String get type => '종류';

  @override
  String get liquid => '액체';

  @override
  String get powder => '가루';

  @override
  String get pods => '캡슐';

  @override
  String get sheets => '시트';

  @override
  String get labelPhoto => '라벨 사진';

  @override
  String get addPhoto => '사진 추가';

  @override
  String get replacePhoto => '사진 바꾸기';

  @override
  String get removePhoto => '사진 삭제';

  @override
  String get photoStoredLocally => '라벨 사진은 이 앱의 로컬 저장공간에만 보관됩니다.';

  @override
  String get doseSetupTitle => '사용량 설정';

  @override
  String get copyFromPackage => '세제 포장에 적힌 값을 그대로 입력하세요.';

  @override
  String get ruleStyle => '라벨이 어떻게 표시되어 있나요?';

  @override
  String get oneStandardDose => '표준 사용량 하나';

  @override
  String get byLoadSize => '세탁물 양별 사용량';

  @override
  String get simpleAdjustments => '기본량 + 가감량';

  @override
  String get fullTable => '전체 표';

  @override
  String get baseDose => '기본 사용량';

  @override
  String get dose => '사용량';

  @override
  String get amount => '양';

  @override
  String get unit => '단위';

  @override
  String get notListed => '내 라벨에 없음';

  @override
  String get useOnlyPrintedValues => '이 제품의 세제 제조사가 표시한 값만 입력하세요.';

  @override
  String get enableSoil => '라벨에서 오염도에 따라 사용량이 달라져요';

  @override
  String get enableWater => '라벨에서 물 경도에 따라 사용량이 달라져요';

  @override
  String get machineVariant => '어떤 세탁기용 안내인가요?';

  @override
  String get machineVariantHelp =>
      '이 제품에 HE/일반형 안내가 따로 있을 때만 선택하세요. 아니면 ‘구분 없음’을 사용하세요.';

  @override
  String get soilAdjustment => '오염도 가감량';

  @override
  String get waterAdjustment => '물 경도 가감량';

  @override
  String get addToBase => '기본 사용량에서 변경';

  @override
  String get customMatrix => '사용량 표 직접 입력';

  @override
  String get matrixHelp =>
      '라벨에 표시된 각 조합을 그대로 입력하세요. 비어 있는 칸은 추측하지 않고 사용 불가로 둡니다.';

  @override
  String get measurementTitle => '뚜껑·스쿱 눈금';

  @override
  String get measurementBody =>
      '뚜껑이나 스쿱의 눈금을 저장하면 결과에 실제 계량 위치를 함께 표시할 수 있습니다.';

  @override
  String get addMarker => '눈금 추가';

  @override
  String get markerName => '눈금 이름';

  @override
  String get markerNamePlaceholder => '예: 뚜껑 2번 선';

  @override
  String get markerAmount => '이 눈금의 양';

  @override
  String betweenMarkers(String lower, String upper) {
    return '$lower와 $upper 사이';
  }

  @override
  String nearMarker(String marker) {
    return '≈ $marker';
  }

  @override
  String belowFirstMarker(String marker) {
    return '$marker보다 아래';
  }

  @override
  String aboveLastMarker(String marker) {
    return '$marker보다 위';
  }

  @override
  String get packageCostTitle => '제품 용량·가격';

  @override
  String get packageQuantity => '제품 용량';

  @override
  String get packagePrice => '가격';

  @override
  String get currency => '통화';

  @override
  String get costOptionalHelp => '선택사항입니다. 1회 세탁 비용 추정에만 사용합니다.';

  @override
  String get estimatedCost => '예상 비용';

  @override
  String get costUnavailable => '제품 가격과 용량을 입력하면 1회 세탁 비용을 볼 수 있습니다.';

  @override
  String get historyTitle => '세탁 기록';

  @override
  String get historyEmptyTitle => '기록된 세탁이 없습니다';

  @override
  String get historyEmptyBody =>
      '기록은 선택사항입니다. 결과를 확인한 뒤 남기고 싶을 때 ‘세탁 기록’을 누르세요.';

  @override
  String get deleteLogTitle => '이 세탁 기록을 삭제할까요?';

  @override
  String get deleteLogBody => '이 로컬 기록 한 건만 삭제됩니다.';

  @override
  String get deleteLogConfirm => '기록 삭제';

  @override
  String get today => '오늘';

  @override
  String get yesterday => '어제';

  @override
  String get settingsTitle => '설정';

  @override
  String get appearance => '화면';

  @override
  String get theme => '테마';

  @override
  String get system => '시스템 설정';

  @override
  String get dark => '다크';

  @override
  String get language => '언어';

  @override
  String get followSystem => '시스템 언어 따르기';

  @override
  String get defaults => '기본값';

  @override
  String get defaultLoad => '기본 세탁물 양';

  @override
  String get defaultSoil => '기본 오염도';

  @override
  String get defaultWater => '기본 물 경도';

  @override
  String get privacy => '개인정보';

  @override
  String get privacyChoices => '광고 개인정보 선택';

  @override
  String get about => 'Laundry Dose 정보';

  @override
  String get help => '도움말';

  @override
  String get version => '버전';

  @override
  String get privacyTitle => '개인정보';

  @override
  String get privacyLocalTitle => '세탁 데이터는 기기에 저장됩니다';

  @override
  String get privacyLocalBody =>
      '세제 프로필, 사용량 규칙, 라벨 사진, 세탁 기록은 이 iPhone에 저장됩니다. Laundry Dose는 계정이나 자체 백엔드를 사용하지 않습니다.';

  @override
  String get privacyAdsTitle => '광고 데이터는 별도입니다';

  @override
  String get privacyAdsBody =>
      '무료 앱은 Google AdMob을 사용합니다. 광고 SDK는 지역과 동의 선택에 따라 기기·광고·진단 정보를 처리할 수 있습니다.';

  @override
  String get privacyNoSaleClaim =>
      'Laundry Dose는 사용자의 세제 정보나 세탁 기록을 판매하지 않습니다.';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get manageConsent => '광고 개인정보 선택 관리';

  @override
  String get helpTitle => 'Laundry Dose 사용 방법';

  @override
  String get helpLabelFirstTitle => '제품 라벨을 기준으로 하세요';

  @override
  String get helpLabelFirstBody =>
      'Laundry Dose는 개인용 라벨 조회 도구이며 모든 세제에 통하는 처방 계산기가 아닙니다. 제품과 판매 국가에 따라 사용량이 다를 수 있습니다.';

  @override
  String get helpHardnessTitle => '물 경도';

  @override
  String get helpHardnessBody =>
      '세제 라벨에 경도별 안내가 있을 때만 경도 규칙을 켜세요. 앱은 임의의 경수 추가량을 만들지 않습니다.';

  @override
  String get helpMachineTitle => 'HE와 일반 세탁기';

  @override
  String get helpMachineBody =>
      '제품에 HE와 일반형 안내가 따로 있으면 내 세탁기에 맞는 안내를 저장하세요. 앱과 세탁기·세제 설명이 다르면 해당 설명서를 따르세요.';

  @override
  String get helpPodsTitle => '캡슐과 시트';

  @override
  String get helpPodsBody => '제품에 표시된 개수를 입력하세요. 앱은 임의로 캡슐을 쪼개어 권장하지 않습니다.';

  @override
  String get disclaimer =>
      'Laundry Dose는 사용자가 제품 라벨에서 입력한 값을 정리해 보여줍니다. 세탁 결과를 보장하지 않습니다. 세제 포장, 의류 세탁라벨, 세탁기 설명과 다르면 해당 지침을 따르세요.';

  @override
  String get aboutBody => '내 세제 라벨의 사용량을 빠르게 찾는 오프라인 중심 소형 유틸리티입니다.';

  @override
  String get noAccount => '계정 없음';

  @override
  String get noSubscription => '구독 없음';

  @override
  String get offlineCore => '핵심 계산기는 오프라인 동작';

  @override
  String get validationRequired => '필수 입력 항목입니다.';

  @override
  String get validationNameTooLong => '60자 이내로 입력하세요.';

  @override
  String get validationPositive => '0보다 큰 값을 입력하세요.';

  @override
  String get validationNonNegative => '0 이상의 값을 입력하세요.';

  @override
  String get validationDoseOrder =>
      '라벨 값을 확인하세요. 적은 세탁물의 사용량이 더 많은 세탁물보다 크게 입력되어 있습니다.';

  @override
  String get validationMarkerOrder => '눈금의 양은 앞선 눈금보다 커야 합니다.';

  @override
  String get validationDuplicateMarker => '같은 양에 두 개의 눈금을 지정할 수 없습니다.';

  @override
  String get validationWholePods => '캡슐은 정수 개수로 입력하세요.';

  @override
  String get validationHalfSheets => '시트는 0.5 단위로 입력하세요.';

  @override
  String get validationCurrency => '가격을 입력했다면 통화를 선택하세요.';

  @override
  String get validationPackageQuantity => '비용 계산을 위해 0보다 큰 제품 용량을 입력하세요.';

  @override
  String get validationTooLarge => '값이 지나치게 커 보입니다. 단위와 제품 라벨을 확인하세요.';

  @override
  String get errorGenericTitle => '문제가 발생했습니다';

  @override
  String get errorGenericBody => '저장된 세탁 데이터는 변경되지 않았습니다. 다시 시도하세요.';

  @override
  String get errorSaveTitle => '저장하지 못했습니다';

  @override
  String get errorPhotoTitle => '사진을 저장하지 못했습니다';

  @override
  String get errorAdIgnored => '';

  @override
  String get offlineNotice => '오프라인입니다. 계산기와 기록은 그대로 사용할 수 있습니다.';

  @override
  String get photoPermissionTitle => '사진 접근을 허용할까요?';

  @override
  String get photoPermissionBody =>
      '이 세제와 함께 보관할 라벨 사진을 선택합니다. Laundry Dose는 사용자가 선택한 사진에만 접근하면 됩니다.';

  @override
  String get openSettings => '설정 열기';

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
  String get unitPod => '캡슐';

  @override
  String get unitPods => '캡슐';

  @override
  String get unitSheet => '시트';

  @override
  String get unitSheets => '시트';

  @override
  String get unitScoop => '스쿱';

  @override
  String get unitScoops => '스쿱';

  @override
  String get estimated => '추정';

  @override
  String get estimatedRemaining => '추정 잔량';

  @override
  String estimatedWashesLeft(num count) {
    return '약 $count회 세탁 가능';
  }

  @override
  String get remainingEstimateHelp => '이 앱에 기록한 세탁만을 바탕으로 한 추정치입니다.';

  @override
  String get setupComplete => '세제를 저장했습니다';

  @override
  String get changesSaved => '변경사항을 저장했습니다';

  @override
  String get unsavedChangesTitle => '변경사항을 버릴까요?';

  @override
  String get unsavedChangesBody => '아직 저장하지 않은 수정사항이 있습니다.';

  @override
  String get discard => '버리기';

  @override
  String get themeLight => '라이트';

  @override
  String get units => '단위';

  @override
  String get unitSystemAuto => '자동';

  @override
  String get unitSystemMetric => '미터법';

  @override
  String get unitSystemUS => '미국식';

  @override
  String get defaultWaterUnknown => '모름';

  @override
  String get increase => '늘리기';

  @override
  String get decrease => '줄이기';

  @override
  String get noChange => '변경 없음';

  @override
  String get checkLabelWarning => '값이 평소보다 커 보입니다. 단위와 제품 라벨을 확인하세요.';

  @override
  String get camera => '카메라';

  @override
  String get photoLibrary => '사진 보관함';

  @override
  String get languageEnglish => '영어';

  @override
  String get languageKorean => '한국어';

  @override
  String get languageJapanese => '일본어';

  @override
  String get languageGerman => '독일어';

  @override
  String get languageFrench => '프랑스어';

  @override
  String get languageSpanish => '스페인어';

  @override
  String get selectLanguage => '언어 선택';

  @override
  String get currentDetergent => '현재 세제';

  @override
  String get reduceMotion => '동작 줄이기';

  @override
  String get reduceMotionHelp => 'iPhone의 동작 줄이기 설정도 함께 따릅니다.';

  @override
  String get selectAdjustment => '조정 방식 선택';

  @override
  String get helpLoadTitle => '세탁물 양 가이드';

  @override
  String get helpLoadBody =>
      '드럼이 얼마나 찼는지는 대략적인 참고만 하세요. Small ≈ 1/3, Medium ≈ 1/2, Large ≈ 3/4 정도이며 세탁기 구조가 다를 수 있으므로 설명서 안내가 다르면 세탁기 설명서를 따르세요.';

  @override
  String get helpMarkersTitle => '뚜껑·스쿱 눈금';

  @override
  String get helpMarkersBody =>
      '내 세제 뚜껑이나 스쿱의 눈금을 한 번 저장하세요. Laundry Dose는 사용자가 입력한 눈금에만 결과를 대응시킵니다.';

  @override
  String get helpCostTitle => '1회 세탁 비용';

  @override
  String get helpCostBody =>
      '제품 용량과 가격을 입력하면 저장된 세제량을 기준으로 1회 비용을 추정합니다. 영수증이나 가격 추적 기능이 아닌 참고용 추정치입니다.';

  @override
  String get helpOfflineTitle => '오프라인 사용';

  @override
  String get helpOfflineBody =>
      '세제 프로필, 라벨 사진, 세탁 기록은 이 iPhone에 저장되며 핵심 용량 계산은 오프라인에서도 작동합니다. 광고, 동의 업데이트, 외부 링크에는 인터넷이 필요할 수 있습니다.';

  @override
  String get supportEmailAction => '이메일 문의';

  @override
  String get licenses => '오픈소스 라이선스';

  @override
  String get invalidProfileTitle => '이 세제 프로필을 확인하세요';

  @override
  String get invalidProfileBody =>
      '저장된 세제량 또는 단위에 올바르지 않은 값이 있습니다. 결과를 사용하기 전에 세제 라벨과 저장값을 다시 비교하세요.';

  @override
  String get reviewProfile => '프로필 확인';

  @override
  String get welcomeTitle => '고민은 조금 덜고,\n세탁은 더 간편하게.';

  @override
  String get welcomeBody => '세제 라벨을 한 번 등록하면 세탁할 때마다 필요한 양을 바로 볼 수 있어요.';

  @override
  String get scanLabel => '라벨 스캔';

  @override
  String get enterManually => '직접 입력';

  @override
  String get localScanNote => '아이폰 안에서 라벨을 읽어요. 영어 라벨을 지원합니다.';

  @override
  String get scanTitle => '사용량 안내 읽기';

  @override
  String get scanBody =>
      '뒷면의 사용량 안내를 밝은 곳에서 정면으로 찍어 주세요. 사용량과 세탁물 크기가 함께 보이게 해 주세요.';

  @override
  String get takePhoto => '사진 촬영';

  @override
  String get choosePhoto => '사진 선택';

  @override
  String get readingLabel => '라벨 읽는 중…';

  @override
  String get reviewScan => '읽은 내용을 확인하세요';

  @override
  String get scanReviewBody =>
      '포장에 적힌 숫자와 비교해 주세요. 다음 화면에서 수정할 수 있어요. 아직 저장되지 않았습니다.';

  @override
  String get scanNoValues => '명확한 사용량을 찾지 못했어요. 라벨 내용을 직접 입력할 수 있습니다.';

  @override
  String get scanFailed => '사진을 읽지 못했어요. 밝은 곳에서 다시 찍거나 직접 입력해 주세요.';

  @override
  String get scanUnavailable => '라벨 읽기는 아이폰에서 사용할 수 있어요. 여기서는 직접 입력할 수 있습니다.';

  @override
  String get continueReview => '확인 후 설정 마치기';

  @override
  String get readText => '사진에서 읽은 글자';

  @override
  String get forThisLoad => '이번 세탁에';

  @override
  String get washSubtitle => '세탁할 때 고민 하나를 덜어드려요.';

  @override
  String get loadSize => '세탁물 크기';

  @override
  String get yourShelf => '내 세제';

  @override
  String get shelfSubtitle => '다음 세탁에도 바로 꺼내 쓰세요.';

  @override
  String get historySubtitle => '세탁한 날을 간단히 기록해요.';

  @override
  String get savedWashes => '기록한 세탁';

  @override
  String get firstDetergent => '내 세제부터 등록하세요';

  @override
  String get loadVisualNote => '통이 찬 정도는 시각적 안내입니다. 세탁기의 적재 지침을 따라 주세요.';

  @override
  String get scanEvidence => '라벨에서 읽은 값';

  @override
  String get scanUnitNote => '명확하게 표시된 양만 입력해요. 찾지 못한 값은 비워 둡니다.';

  @override
  String get useForWash => '이 세제로 세탁';

  @override
  String get standardDoseLoadHelp =>
      '이 세제는 사용량 한 개가 저장되어 있어요. 소량·보통·많음 중에서 고르려면 라벨에 적힌 크기별 사용량을 추가해 주세요.';

  @override
  String get addLoadSizeAmounts => '크기별 사용량 추가';
}
