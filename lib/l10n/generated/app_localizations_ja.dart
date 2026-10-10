// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'Laundry Dose';

  @override
  String get tabDose => '使用量';

  @override
  String get tabDetergents => '洗剤';

  @override
  String get tabHistory => '履歴';

  @override
  String get tabSettings => '設定';

  @override
  String get onboarding1Title => 'ちょうどいい量を。';

  @override
  String get onboarding1Body => '洗剤ラベルの使用量を一度保存すれば、洗濯のたびに読み直す必要はありません。';

  @override
  String get onboarding2Title => '数秒で使用量を確認。';

  @override
  String get onboarding2Body => '洗濯物の量、汚れ、硬水など、そのラベルに実際に書かれている項目だけを選びます。';

  @override
  String get onboarding3Title => '自分のラベルを、自分のiPhoneに。';

  @override
  String get onboarding3Body =>
      'アカウントもサブスクも不要。洗剤設定、ラベル写真、洗濯履歴はこのiPhoneに保存されます。';

  @override
  String get getStarted => 'はじめる';

  @override
  String get continueLabel => '続ける';

  @override
  String get skip => 'スキップ';

  @override
  String get done => '完了';

  @override
  String get save => '保存';

  @override
  String get cancel => 'キャンセル';

  @override
  String get back => '戻る';

  @override
  String get close => '閉じる';

  @override
  String get edit => '編集';

  @override
  String get delete => '削除';

  @override
  String get retry => 'もう一度';

  @override
  String get learnMore => '詳しく見る';

  @override
  String get notNow => '今はしない';

  @override
  String get homeTitle => 'Laundry Dose';

  @override
  String get chooseDetergent => '洗剤を選択';

  @override
  String get changeDetergent => '洗剤を変更';

  @override
  String get noDetergentTitle => 'まず洗剤を追加してください';

  @override
  String get noDetergentBody => 'パッケージの使用量を一度入力すると、次回からすぐ確認できます。';

  @override
  String get addDetergent => '洗剤を追加';

  @override
  String get recommendedDose => 'ラベル使用量';

  @override
  String get basedOnYourLabel => 'この製品ラベルから保存した値に基づきます。';

  @override
  String get costThisWash => '今回の洗濯';

  @override
  String get logWash => '洗濯を記録';

  @override
  String get washLogged => '洗濯を記録しました';

  @override
  String get undo => '元に戻す';

  @override
  String get missingRuleTitle => 'このラベル値を追加';

  @override
  String get missingRuleBody =>
      'この組み合わせの使用量が保存されていません。推測せず、洗剤パッケージの表示値を確認して追加してください。';

  @override
  String get addLabelValue => 'ラベル値を追加';

  @override
  String get load => '洗濯物量';

  @override
  String get soil => '汚れ';

  @override
  String get water => '水の硬度';

  @override
  String get machine => '洗濯機';

  @override
  String get small => '少量';

  @override
  String get medium => '中量';

  @override
  String get large => '多量';

  @override
  String get extraLarge => '特大';

  @override
  String get light => '軽い';

  @override
  String get normal => '普通';

  @override
  String get heavy => 'ひどい';

  @override
  String get soft => '軟水';

  @override
  String get hard => '硬水';

  @override
  String get unknown => 'わからない';

  @override
  String get anyMachine => '指定なし';

  @override
  String get heMachine => 'HE';

  @override
  String get standardMachine => '標準';

  @override
  String get smallHelp => 'ドラムの約1/3';

  @override
  String get mediumHelp => 'ドラムの約1/2';

  @override
  String get largeHelp => 'ドラムの約3/4';

  @override
  String get xlHelp => '3/4以上、洗濯機の許容範囲内';

  @override
  String get loadHelpFootnote => 'ドラムの充填率は目安です。洗濯機の取扱説明書と異なる場合はそちらに従ってください。';

  @override
  String get unknownWaterHelp => '水の硬度がわからない場合は、この洗剤設定で保存した既定の行を使います。';

  @override
  String get mediumFallbackNote => 'このプロファイルに中硬度の行があるため、「わからない」は中硬度を使用します。';

  @override
  String get detergentsTitle => '洗剤';

  @override
  String get detergentsEmptyTitle => '洗剤がまだありません';

  @override
  String get detergentsEmptyBody => '実際に使う洗剤を追加し、ラベルの使用量を入力してください。';

  @override
  String get defaultBadge => '既定';

  @override
  String get setAsDefault => '既定に設定';

  @override
  String get duplicate => '複製';

  @override
  String get duplicateForAnotherMachine => '別の洗濯機用に複製';

  @override
  String get deleteDetergentTitle => 'この洗剤を削除しますか？';

  @override
  String get deleteDetergentBody =>
      '保存したルールとラベル写真が削除されます。既存の洗濯履歴のスナップショットは残ります。';

  @override
  String get deleteDetergentConfirm => '洗剤を削除';

  @override
  String get addDetergentTitle => '洗剤を追加';

  @override
  String get editDetergentTitle => '洗剤を編集';

  @override
  String get quickSetup => 'クイック設定';

  @override
  String get advancedRules => '詳細ルール';

  @override
  String get name => '名前';

  @override
  String get brandOptional => 'ブランド（任意）';

  @override
  String get detergentNamePlaceholder => '例：普段使いの液体洗剤';

  @override
  String get brandPlaceholder => '例：ブランド名';

  @override
  String get type => '種類';

  @override
  String get liquid => '液体';

  @override
  String get powder => '粉末';

  @override
  String get pods => 'ポッド';

  @override
  String get sheets => 'シート';

  @override
  String get labelPhoto => 'ラベル写真';

  @override
  String get addPhoto => '写真を追加';

  @override
  String get replacePhoto => '写真を変更';

  @override
  String get removePhoto => '写真を削除';

  @override
  String get photoStoredLocally => 'ラベル写真はこのアプリのローカルストレージに保存されます。';

  @override
  String get doseSetupTitle => '使用量設定';

  @override
  String get copyFromPackage => '洗剤パッケージに書かれた値をそのまま入力してください。';

  @override
  String get ruleStyle => 'ラベルはどの形式ですか？';

  @override
  String get oneStandardDose => '標準量1つ';

  @override
  String get byLoadSize => '洗濯物量ごと';

  @override
  String get simpleAdjustments => '基本量＋調整';

  @override
  String get fullTable => '完全な表';

  @override
  String get baseDose => '基本量';

  @override
  String get dose => '使用量';

  @override
  String get amount => '量';

  @override
  String get unit => '単位';

  @override
  String get notListed => 'ラベルに記載なし';

  @override
  String get useOnlyPrintedValues => 'この製品についてメーカーが印刷した値だけを入力してください。';

  @override
  String get enableSoil => '汚れ具合で使用量が変わる';

  @override
  String get enableWater => '水の硬度で使用量が変わる';

  @override
  String get machineVariant => 'どの洗濯機向けの表示ですか？';

  @override
  String get machineVariantHelp =>
      'この製品にHEと標準用の別表示がある場合だけ選びます。なければ「指定なし」を使います。';

  @override
  String get soilAdjustment => '汚れの調整量';

  @override
  String get waterAdjustment => '水硬度の調整量';

  @override
  String get addToBase => '基本量からの増減';

  @override
  String get customMatrix => 'ラベル表を入力';

  @override
  String get matrixHelp => '印刷された組み合わせをそのまま入力します。空欄は推測せず使用不可のままにします。';

  @override
  String get measurementTitle => 'キャップ・スクープの目盛り';

  @override
  String get measurementBody => 'キャップやスクープの目盛りを保存すると、結果に実際の位置を表示できます。';

  @override
  String get addMarker => '目盛りを追加';

  @override
  String get markerName => '目盛り名';

  @override
  String get markerNamePlaceholder => '例：キャップ線2';

  @override
  String get markerAmount => 'この目盛りの量';

  @override
  String betweenMarkers(String lower, String upper) {
    return '$lower と $upper の間';
  }

  @override
  String nearMarker(String marker) {
    return '≈ $marker';
  }

  @override
  String belowFirstMarker(String marker) {
    return '$marker より下';
  }

  @override
  String aboveLastMarker(String marker) {
    return '$marker より上';
  }

  @override
  String get packageCostTitle => '容量と価格';

  @override
  String get packageQuantity => '内容量';

  @override
  String get packagePrice => '価格';

  @override
  String get currency => '通貨';

  @override
  String get costOptionalHelp => '任意。1回の洗濯コストの推定にのみ使います。';

  @override
  String get estimatedCost => '推定コスト';

  @override
  String get costUnavailable => '価格と内容量を追加すると1回あたりのコストを表示できます。';

  @override
  String get historyTitle => '履歴';

  @override
  String get historyEmptyTitle => '洗濯履歴はありません';

  @override
  String get historyEmptyBody => '記録は任意です。結果を確認後、残したいときに「洗濯を記録」を押してください。';

  @override
  String get deleteLogTitle => 'この洗濯を削除しますか？';

  @override
  String get deleteLogBody => 'このローカル履歴1件だけが削除されます。';

  @override
  String get deleteLogConfirm => '履歴を削除';

  @override
  String get today => '今日';

  @override
  String get yesterday => '昨日';

  @override
  String get settingsTitle => '設定';

  @override
  String get appearance => '表示';

  @override
  String get theme => 'テーマ';

  @override
  String get system => 'システム';

  @override
  String get dark => 'ダーク';

  @override
  String get language => '言語';

  @override
  String get followSystem => 'システムに従う';

  @override
  String get defaults => '既定値';

  @override
  String get defaultLoad => '既定の洗濯物量';

  @override
  String get defaultSoil => '既定の汚れ';

  @override
  String get defaultWater => '既定の水硬度';

  @override
  String get privacy => 'プライバシー';

  @override
  String get privacyChoices => '広告プライバシー設定';

  @override
  String get about => 'Laundry Doseについて';

  @override
  String get help => 'ヘルプ';

  @override
  String get version => 'バージョン';

  @override
  String get privacyTitle => 'プライバシー';

  @override
  String get privacyLocalTitle => '洗濯データは端末内に保存';

  @override
  String get privacyLocalBody =>
      '洗剤プロファイル、使用量ルール、ラベル写真、洗濯履歴はこのiPhoneに保存されます。Laundry Doseにはアカウントや独自バックエンドはありません。';

  @override
  String get privacyAdsTitle => '広告データは別です';

  @override
  String get privacyAdsBody =>
      '無料版はGoogle AdMobを使用します。広告SDKは地域と同意設定に応じて、端末・広告・診断情報を処理する場合があります。';

  @override
  String get privacyNoSaleClaim => 'Laundry Doseは洗剤情報や洗濯履歴を販売しません。';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get manageConsent => '広告プライバシー設定を管理';

  @override
  String get helpTitle => 'Laundry Doseの使い方';

  @override
  String get helpLabelFirstTitle => '製品ラベルを使う';

  @override
  String get helpLabelFirstBody =>
      'Laundry Doseは個人用のラベル参照ツールで、すべての洗剤に共通する処方計算機ではありません。製品や販売地域で使用量は異なります。';

  @override
  String get helpHardnessTitle => '水の硬度';

  @override
  String get helpHardnessBody =>
      '洗剤ラベルに硬度別の指示がある場合だけ有効にしてください。一般的な硬水加算量をアプリが勝手に作ることはありません。';

  @override
  String get helpMachineTitle => 'HEと標準洗濯機';

  @override
  String get helpMachineBody =>
      '製品にHEと標準の別指示がある場合は、お使いの洗濯機に合う指示を保存してください。アプリと取扱説明が異なる場合は製品と洗濯機の説明に従ってください。';

  @override
  String get helpPodsTitle => 'ポッドとシート';

  @override
  String get helpPodsBody => '製品に印刷された個数を入力してください。ポッドの分割量をアプリが作ることはありません。';

  @override
  String get disclaimer =>
      'Laundry Doseは、製品ラベルから入力した値を整理して表示します。洗浄結果を保証するものではありません。洗剤パッケージ、衣類表示、洗濯機の説明と異なる場合はそれらに従ってください。';

  @override
  String get aboutBody => '自分の洗剤ラベルにある使用量をすばやく確認する、オフライン中心の小さなユーティリティです。';

  @override
  String get noAccount => 'アカウント不要';

  @override
  String get noSubscription => 'サブスクなし';

  @override
  String get offlineCore => '基本計算はオフラインで動作';

  @override
  String get validationRequired => '必須項目です。';

  @override
  String get validationNameTooLong => '60文字以内で入力してください。';

  @override
  String get validationPositive => '0より大きい値を入力してください。';

  @override
  String get validationNonNegative => '0以上の値を入力してください。';

  @override
  String get validationDoseOrder => 'ラベル値を確認してください。少量の使用量が多量より大きくなっています。';

  @override
  String get validationMarkerOrder => '目盛り量は前の目盛りより大きくしてください。';

  @override
  String get validationDuplicateMarker => '同じ量に2つの目盛りは設定できません。';

  @override
  String get validationWholePods => 'ポッドは整数個で入力してください。';

  @override
  String get validationHalfSheets => 'シートは0.5単位で入力してください。';

  @override
  String get validationCurrency => '価格を入力した場合は通貨を選んでください。';

  @override
  String get validationPackageQuantity => 'コスト計算には0より大きい内容量が必要です。';

  @override
  String get validationTooLarge => '値が非常に大きく見えます。単位と製品ラベルを確認してください。';

  @override
  String get errorGenericTitle => '問題が発生しました';

  @override
  String get errorGenericBody => '保存済みの洗濯データは変更されていません。もう一度お試しください。';

  @override
  String get errorSaveTitle => '保存できませんでした';

  @override
  String get errorPhotoTitle => '写真を保存できませんでした';

  @override
  String get errorAdIgnored => '';

  @override
  String get offlineNotice => 'オフラインです。計算機と履歴は引き続き使えます。';

  @override
  String get photoPermissionTitle => '写真へのアクセスを許可しますか？';

  @override
  String get photoPermissionBody =>
      'この洗剤と一緒に保存するラベル写真を選びます。Laundry Doseは選択した写真へのアクセスだけで十分です。';

  @override
  String get openSettings => '設定を開く';

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
  String get unitPod => 'ポッド';

  @override
  String get unitPods => 'ポッド';

  @override
  String get unitSheet => 'シート';

  @override
  String get unitSheets => 'シート';

  @override
  String get unitScoop => 'スクープ';

  @override
  String get unitScoops => 'スクープ';

  @override
  String get estimated => '推定';

  @override
  String get estimatedRemaining => '推定残量';

  @override
  String estimatedWashesLeft(num count) {
    return 'あと約$count回';
  }

  @override
  String get remainingEstimateHelp => 'このアプリに記録した洗濯だけに基づく推定です。';

  @override
  String get setupComplete => '洗剤を保存しました';

  @override
  String get changesSaved => '変更を保存しました';

  @override
  String get unsavedChangesTitle => '変更を破棄しますか？';

  @override
  String get unsavedChangesBody => 'まだ保存していない変更があります。';

  @override
  String get discard => '破棄';

  @override
  String get themeLight => 'ライト';

  @override
  String get units => '単位';

  @override
  String get unitSystemAuto => '自動';

  @override
  String get unitSystemMetric => 'メートル法';

  @override
  String get unitSystemUS => '米国式';

  @override
  String get defaultWaterUnknown => '不明';

  @override
  String get increase => '増やす';

  @override
  String get decrease => '減らす';

  @override
  String get noChange => '変更なし';

  @override
  String get checkLabelWarning => '値が通常より大きく見えます。単位と製品ラベルを確認してください。';

  @override
  String get camera => 'カメラ';

  @override
  String get photoLibrary => '写真ライブラリ';

  @override
  String get languageEnglish => '英語';

  @override
  String get languageKorean => '韓国語';

  @override
  String get languageJapanese => '日本語';

  @override
  String get languageGerman => 'ドイツ語';

  @override
  String get languageFrench => 'フランス語';

  @override
  String get languageSpanish => 'スペイン語';

  @override
  String get selectLanguage => '言語を選択';

  @override
  String get currentDetergent => '現在の洗剤';

  @override
  String get reduceMotion => 'モーションを減らす';

  @override
  String get reduceMotionHelp => 'iPhoneの「視差効果を減らす」設定にも従います。';

  @override
  String get selectAdjustment => '調整方法を選択';

  @override
  String get helpLoadTitle => '洗濯物量の目安';

  @override
  String get helpLoadBody =>
      'ドラムの埋まり具合はおおまかな目安としてのみ使ってください。Small ≈ 1/3、Medium ≈ 1/2、Large ≈ 3/4 が目安です。洗濯機の構造により異なるため、取扱説明書の案内が違う場合はそちらを優先してください。';

  @override
  String get helpMarkersTitle => 'キャップ・スプーンの目盛り';

  @override
  String get helpMarkersBody =>
      '自分のキャップやスプーンの目盛りを一度保存します。Laundry Dose は、入力した目盛りにだけ結果を対応させます。';

  @override
  String get helpCostTitle => '1回あたりの費用';

  @override
  String get helpCostBody =>
      '内容量と価格を入力すると、保存した使用量をもとに1回あたりの費用を推定します。レシートや価格追跡ではなく参考値です。';

  @override
  String get helpOfflineTitle => 'オフライン利用';

  @override
  String get helpOfflineBody =>
      '洗剤プロファイル、ラベル写真、洗濯履歴はこのiPhoneに保存され、基本の用量確認はオフラインで使えます。広告、同意情報の更新、外部リンクには通信が必要な場合があります。';

  @override
  String get supportEmailAction => 'メールで問い合わせ';

  @override
  String get licenses => 'オープンソースライセンス';

  @override
  String get invalidProfileTitle => 'この洗剤プロファイルを確認してください';

  @override
  String get invalidProfileBody =>
      '保存した使用量または単位に無効な値があります。結果を使う前に、この洗剤を開いて製品ラベルと保存値を確認してください。';

  @override
  String get reviewProfile => 'プロファイルを確認';

  @override
  String get welcomeTitle => '迷う時間を減らして、\n洗濯をもっと気軽に。';

  @override
  String get welcomeBody => '洗剤の表示を一度登録すれば、毎回必要な量をすぐ確認できます。';

  @override
  String get scanLabel => 'ラベルをスキャン';

  @override
  String get enterManually => '手入力する';

  @override
  String get localScanNote => 'iPhone内で読み取ります。英語のラベルに対応。';

  @override
  String get scanTitle => '使用量の表示を読む';

  @override
  String get scanBody => '明るい場所で裏面の説明を正面から撮影してください。使用量と洗濯物の量を一緒に写してください。';

  @override
  String get takePhoto => '写真を撮る';

  @override
  String get choosePhoto => '写真を選ぶ';

  @override
  String get readingLabel => 'ラベルを読んでいます…';

  @override
  String get reviewScan => '読み取った内容を確認';

  @override
  String get scanReviewBody => 'パッケージの数字と比較してください。次の画面で編集できます。まだ保存されていません。';

  @override
  String get scanNoValues => '明確な使用量が見つかりません。説明を手入力できます。';

  @override
  String get scanFailed => '写真を読み取れませんでした。明るい場所で再撮影するか、手入力してください。';

  @override
  String get scanUnavailable => 'ラベル読み取りはiPhoneで利用できます。ここでは手入力できます。';

  @override
  String get continueReview => '確認して設定を完了';

  @override
  String get readText => '写真から読んだ文字';

  @override
  String get forThisLoad => '今回の洗濯に';

  @override
  String get washSubtitle => '考えることを、ひとつ少なく。';

  @override
  String get loadSize => '洗濯物の量';

  @override
  String get yourShelf => 'マイ洗剤';

  @override
  String get shelfSubtitle => '次の洗濯でもすぐ使えるように。';

  @override
  String get historySubtitle => '洗濯した日の小さな記録。';

  @override
  String get savedWashes => '記録した洗濯';

  @override
  String get firstDetergent => '洗剤の登録から始めましょう';

  @override
  String get loadVisualNote => 'ドラムの図は目安です。洗濯機の容量の説明に従ってください。';

  @override
  String get scanEvidence => 'ラベルから読み取った値';

  @override
  String get scanUnitNote => '明確な使用量だけを入力します。不明な値は空欄のままです。';

  @override
  String get useForWash => 'この洗剤で洗濯';

  @override
  String get standardDoseLoadHelp =>
      'この洗剤には使用量が1つ保存されています。少量・標準・多量を選ぶには、ラベルに記載された洗濯物の量ごとの使用量を追加してください。';

  @override
  String get addLoadSizeAmounts => '洗濯物の量ごとの使用量を追加';
}
