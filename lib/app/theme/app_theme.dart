import 'package:flutter/material.dart';
import 'design_tokens.dart';

class AppTheme {
  static ThemeData light() => _theme(Brightness.light);
  static ThemeData dark() => _theme(Brightness.dark);
  static ThemeData _theme(Brightness b) {
    final dark = b == Brightness.dark;
    final primary = dark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final bg = dark ? AppColors.darkBackground : AppColors.lightBackground;
    final surface = dark ? AppColors.darkSurface : AppColors.lightSurface;
    final text = dark ? AppColors.darkText : AppColors.lightText;
    final secondary = dark ? AppColors.darkSecondary : AppColors.lightSecondary;
    final divider = dark ? AppColors.darkDivider : AppColors.lightDivider;
    final scheme = ColorScheme(
      brightness: b,
      primary: primary,
      onPrimary: dark ? const Color(0xFF172D39) : Colors.white,
      secondary: primary,
      onSecondary: dark ? const Color(0xFF172D39) : Colors.white,
      primaryContainer: dark
          ? AppColors.darkSurfaceTint
          : AppColors.lightSurfaceTint,
      onPrimaryContainer: text,
      error: dark ? AppColors.darkError : AppColors.lightError,
      onError: dark ? const Color(0xFF690005) : Colors.white,
      surface: surface,
      onSurface: text,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: b,
      colorScheme: scheme,
      scaffoldBackgroundColor: bg,
      dividerColor: divider,
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        foregroundColor: text,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: secondary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: bg,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          height: 1.12,
          letterSpacing: -1.1,
          fontWeight: FontWeight.w700,
          color: text,
        ),
        titleMedium: TextStyle(
          fontSize: 17,
          height: 22 / 17,
          fontWeight: FontWeight.w600,
          color: text,
        ),
        bodyLarge: TextStyle(fontSize: 16, height: 22 / 16, color: text),
        bodyMedium: TextStyle(fontSize: 15, height: 20 / 15, color: text),
        bodySmall: TextStyle(fontSize: 13, height: 18 / 13, color: secondary),
        labelLarge: const TextStyle(
          fontSize: 15,
          height: 20 / 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppMetrics.cardRadius),
          side: BorderSide(color: divider),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppMetrics.fieldRadius),
          borderSide: BorderSide(color: divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppMetrics.fieldRadius),
          borderSide: BorderSide(color: divider),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(AppMetrics.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppMetrics.buttonRadius),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppMetrics.buttonRadius),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        elevation: 0,
        height: 74,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: 24,
            color: states.contains(WidgetState.selected) ? primary : secondary,
          ),
        ),
        labelTextStyle: WidgetStateProperty.all(
          TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: text),
        ),
        indicatorColor: dark
            ? AppColors.darkSurfaceTint
            : AppColors.lightSurfaceTint,
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(const Size(44, 44)),
        ),
      ),
    );
  }
}
