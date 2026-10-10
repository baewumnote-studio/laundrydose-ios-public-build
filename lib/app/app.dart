import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/accessibility/motion_preferences.dart';
import '../core/domain/enums.dart';
import '../core/domain/models.dart';
import '../core/localization/l10n.dart';
import '../features/onboarding/onboarding_page.dart';
import '../features/shell/app_shell.dart';
import '../l10n/generated/app_localizations.dart';
import 'providers.dart';
import 'theme/app_theme.dart';

class LaundryDoseApp extends ConsumerStatefulWidget {
  const LaundryDoseApp({super.key});
  @override
  ConsumerState<LaundryDoseApp> createState() => _LaundryDoseAppState();
}

class _LaundryDoseAppState extends ConsumerState<LaundryDoseApp>
    with WidgetsBindingObserver {
  bool _adBootstrapChecked = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAccessibilityFeatures() {
    if (mounted) setState(() {});
  }

  Future<void> _maybeBootstrapAds() async {
    if (_adBootstrapChecked) return;
    _adBootstrapChecked = true;
    final repository = ref.read(adStateRepositoryProvider);
    final state = await repository.get();
    if (!state.firstSessionCompleted) {
      await repository.write(
        AdStateModel(
          lifetimeSuccessfulLogs: state.lifetimeSuccessfulLogs,
          lastInterstitialAtUtc: state.lastInterstitialAtUtc,
          adsShownToday: state.adsShownToday,
          adsShownDateLocal: state.adsShownDateLocal,
          firstSessionCompleted: true,
          lastEligibilityConsumedLogId: state.lastEligibilityConsumedLogId,
        ),
      );
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final consent = await ref.read(consentServiceProvider).gather();
    if (!consent.canRequestAds) return;
    final ads = ref.read(adServiceProvider);
    await ads.initialize();
    unawaited(ads.preload());
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final data = settings.value;
    if (data?.onboardingCompleted == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _maybeBootstrapAds());
    }
    final theme = switch (data?.themeMode ?? ThemeChoice.system) {
      ThemeChoice.system => ThemeMode.system,
      ThemeChoice.light => ThemeMode.light,
      ThemeChoice.dark => ThemeMode.dark,
    };
    final locale = data?.localeOverride == null
        ? null
        : Locale(data!.localeOverride!);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laundry Dose',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: theme,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        final media = MediaQuery.of(context);
        final accessibility = WidgetsBinding.instance.accessibilityFeatures;
        final reduce = shouldReduceMotion(
          appChoice: data?.reducedMotionOverride ?? ReducedMotionChoice.system,
          platformReduceMotion: accessibility.reduceMotion,
          platformDisableAnimations: accessibility.disableAnimations,
        );
        return MediaQuery(
          data: media.copyWith(
            disableAnimations: media.disableAnimations || reduce,
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: settings.when(
        data: (value) => value.onboardingCompleted
            ? const AppShell()
            : const OnboardingPage(),
        loading: () => const _Boot(),
        error: (_, _) => _BootError(
          onRetry: () {
            _adBootstrapChecked = false;
            ref.invalidate(databaseProvider);
          },
        ),
      ),
    );
  }
}

class _Boot extends StatelessWidget {
  const _Boot();
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator.adaptive()));
}

class _BootError extends StatelessWidget {
  const _BootError({required this.onRetry});
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 44,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  l.errorGenericTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(l.errorGenericBody, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: Text(l.retry),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
