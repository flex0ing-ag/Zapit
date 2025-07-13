import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the campus food ordering application.
class AppTheme {
  AppTheme._();

  // Campus Food Ordering Color Palette
  // Primary Orange Colors
  static const Color primaryOrange = Color(0xFFFF6B35);
  static const Color deepOrange = Color(0xFFE55A2B);
  static const Color softOrange = Color(0xFFFFF4F1);

  // Base Colors
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color warmGray = Color(0xFFF8F9FA);
  static const Color textCharcoal = Color(0xFF2D3436);
  static const Color secondaryGray = Color(0xFF636E72);
  static const Color lightBorder = Color(0xFFE9ECEF);

  // Status Colors
  static const Color successGreen = Color(0xFF00B894);
  static const Color alertRed = Color(0xFFE17055);

  // Dark Theme Colors
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color cardDark = Color(0xFF2D2D2D);
  static const Color textHighEmphasisDark = Color(0xDEFFFFFF);
  static const Color textMediumEmphasisDark = Color(0x99FFFFFF);
  static const Color textDisabledDark = Color(0x61FFFFFF);
  static const Color dividerDark = Color(0x1FFFFFFF);
  static const Color shadowDark = Color(0x1FFFFFFF);

  // Light Theme Text Colors
  static const Color textHighEmphasisLight = Color(0xDE000000);
  static const Color textMediumEmphasisLight = Color(0x99000000);
  static const Color textDisabledLight = Color(0x61000000);

  // Shadow Colors
  static const Color shadowLight = Color(0x1A636E72);

  /// Light theme optimized for campus food ordering
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryOrange,
          onPrimary: pureWhite,
          primaryContainer: softOrange,
          onPrimaryContainer: textCharcoal,
          secondary: successGreen,
          onSecondary: pureWhite,
          secondaryContainer: successGreen.withValues(alpha: 0.1),
          onSecondaryContainer: textCharcoal,
          tertiary: deepOrange,
          onTertiary: pureWhite,
          tertiaryContainer: deepOrange.withValues(alpha: 0.1),
          onTertiaryContainer: textCharcoal,
          error: alertRed,
          onError: pureWhite,
          surface: pureWhite,
          onSurface: textCharcoal,
          onSurfaceVariant: secondaryGray,
          outline: lightBorder,
          outlineVariant: lightBorder.withValues(alpha: 0.5),
          shadow: shadowLight,
          scrim: textCharcoal.withValues(alpha: 0.5),
          inverseSurface: textCharcoal,
          onInverseSurface: pureWhite,
          inversePrimary: primaryOrange.withValues(alpha: 0.8)),
      scaffoldBackgroundColor: pureWhite,
      cardColor: pureWhite,
      dividerColor: lightBorder,

      // AppBar Theme - Clean and minimal for campus efficiency
      appBarTheme: AppBarTheme(
          backgroundColor: pureWhite,
          foregroundColor: textCharcoal,
          elevation: 0,
          shadowColor: shadowLight,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textCharcoal,
              letterSpacing: -0.2),
          iconTheme: const IconThemeData(color: textCharcoal, size: 24)),

      // Card Theme - Subtle elevation for food items
      cardTheme: CardThemeData(
          color: pureWhite,
          elevation: 2.0,
          shadowColor: shadowLight,
          surfaceTintColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),

      // Bottom Navigation - Campus-friendly navigation
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: pureWhite,
          selectedItemColor: primaryOrange,
          unselectedItemColor: secondaryGray,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400)),

      // Floating Action Button - Contextual morphing button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryOrange,
          foregroundColor: pureWhite,
          elevation: 4.0,
          shape: CircleBorder()),

      // Button Themes - Optimized for thumb-friendly interaction
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: pureWhite,
              backgroundColor: primaryOrange,
              disabledForegroundColor: textDisabledLight,
              disabledBackgroundColor: lightBorder,
              elevation: 2,
              shadowColor: shadowLight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              minimumSize: const Size(88, 48),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: primaryOrange,
              disabledForegroundColor: textDisabledLight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              minimumSize: const Size(88, 48),
              side: const BorderSide(color: primaryOrange, width: 1.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: primaryOrange,
              disabledForegroundColor: textDisabledLight,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              minimumSize: const Size(64, 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1))),

      // Typography - Inter font family for excellent mobile readability
      textTheme: _buildTextTheme(isLight: true),

      // Input Decoration - Clean form fields for quick ordering
      inputDecorationTheme: InputDecorationTheme(
          fillColor: warmGray,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: lightBorder, width: 1)),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: lightBorder, width: 1)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: primaryOrange, width: 2)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: alertRed, width: 1)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: alertRed, width: 2)),
          labelStyle: GoogleFonts.inter(color: secondaryGray, fontSize: 16, fontWeight: FontWeight.w400),
          hintStyle: GoogleFonts.inter(color: textDisabledLight, fontSize: 16, fontWeight: FontWeight.w400),
          prefixIconColor: secondaryGray,
          suffixIconColor: secondaryGray),

      // Switch Theme
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryOrange;
        }
        return lightBorder;
      }), trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryOrange.withValues(alpha: 0.3);
        }
        return lightBorder.withValues(alpha: 0.5);
      })),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return primaryOrange;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(pureWhite),
          side: const BorderSide(color: lightBorder, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),

      // Radio Theme
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryOrange;
        }
        return lightBorder;
      })),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryOrange, linearTrackColor: lightBorder, circularTrackColor: lightBorder),

      // Slider Theme
      sliderTheme: SliderThemeData(activeTrackColor: primaryOrange, thumbColor: primaryOrange, overlayColor: primaryOrange.withValues(alpha: 0.2), inactiveTrackColor: lightBorder, valueIndicatorColor: primaryOrange, valueIndicatorTextStyle: GoogleFonts.robotoMono(color: pureWhite, fontSize: 12, fontWeight: FontWeight.w500)),

      // Tab Bar Theme - For category filtering
      tabBarTheme: TabBarThemeData(
        labelColor: primaryOrange,
        unselectedLabelColor: secondaryGray,
        indicatorColor: primaryOrange,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
      ),

      // Tooltip Theme
      tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: textCharcoal.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8)), textStyle: GoogleFonts.inter(color: pureWhite, fontSize: 12, fontWeight: FontWeight.w400), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),

      // SnackBar Theme - Order status updates
      snackBarTheme: SnackBarThemeData(backgroundColor: textCharcoal, contentTextStyle: GoogleFonts.inter(color: pureWhite, fontSize: 14, fontWeight: FontWeight.w400), actionTextColor: primaryOrange, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),

      // Expansion Tile Theme - For progressive disclosure
      expansionTileTheme: ExpansionTileThemeData(backgroundColor: warmGray, collapsedBackgroundColor: pureWhite, iconColor: primaryOrange, collapsedIconColor: secondaryGray, textColor: textCharcoal, collapsedTextColor: textCharcoal, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),

      // List Tile Theme
      listTileTheme: ListTileThemeData(contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), tileColor: pureWhite, selectedTileColor: softOrange, iconColor: secondaryGray, selectedColor: primaryOrange, textColor: textCharcoal),

      // Chip Theme - For tags and filters
      chipTheme: ChipThemeData(backgroundColor: warmGray, selectedColor: softOrange, disabledColor: lightBorder, labelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: textCharcoal), secondaryLabelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: primaryOrange), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), dialogTheme: DialogThemeData(backgroundColor: pureWhite));

  /// Dark theme for campus food ordering
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: primaryOrange,
          onPrimary: textCharcoal,
          primaryContainer: deepOrange,
          onPrimaryContainer: pureWhite,
          secondary: successGreen,
          onSecondary: textCharcoal,
          secondaryContainer: successGreen.withValues(alpha: 0.2),
          onSecondaryContainer: pureWhite,
          tertiary: primaryOrange.withValues(alpha: 0.8),
          onTertiary: textCharcoal,
          tertiaryContainer: primaryOrange.withValues(alpha: 0.2),
          onTertiaryContainer: pureWhite,
          error: alertRed,
          onError: pureWhite,
          surface: surfaceDark,
          onSurface: textHighEmphasisDark,
          onSurfaceVariant: textMediumEmphasisDark,
          outline: dividerDark,
          outlineVariant: dividerDark.withValues(alpha: 0.5),
          shadow: shadowDark,
          scrim: Colors.black.withValues(alpha: 0.5),
          inverseSurface: pureWhite,
          onInverseSurface: textCharcoal,
          inversePrimary: deepOrange),
      scaffoldBackgroundColor: backgroundDark,
      cardColor: cardDark,
      dividerColor: dividerDark,

      // AppBar Theme - Dark mode
      appBarTheme: AppBarTheme(
          backgroundColor: surfaceDark,
          foregroundColor: textHighEmphasisDark,
          elevation: 0,
          shadowColor: shadowDark,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textHighEmphasisDark,
              letterSpacing: -0.2),
          iconTheme:
              const IconThemeData(color: textHighEmphasisDark, size: 24)),

      // Card Theme - Dark mode
      cardTheme: CardThemeData(
          color: cardDark,
          elevation: 2.0,
          shadowColor: shadowDark,
          surfaceTintColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),

      // Bottom Navigation - Dark mode
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: surfaceDark,
          selectedItemColor: primaryOrange,
          unselectedItemColor: textMediumEmphasisDark,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400)),

      // Floating Action Button - Dark mode
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryOrange,
          foregroundColor: textCharcoal,
          elevation: 4.0,
          shape: CircleBorder()),

      // Button Themes - Dark mode
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: textCharcoal,
              backgroundColor: primaryOrange,
              disabledForegroundColor: textDisabledDark,
              disabledBackgroundColor: dividerDark,
              elevation: 2,
              shadowColor: shadowDark,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              minimumSize: const Size(88, 48),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: primaryOrange,
              disabledForegroundColor: textDisabledDark,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              minimumSize: const Size(88, 48),
              side: const BorderSide(color: primaryOrange, width: 1.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: primaryOrange,
              disabledForegroundColor: textDisabledDark,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              minimumSize: const Size(64, 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1))),

      // Typography - Dark mode
      textTheme: _buildTextTheme(isLight: false),

      // Input Decoration - Dark mode
      inputDecorationTheme: InputDecorationTheme(
          fillColor: backgroundDark,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: dividerDark, width: 1)),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: dividerDark, width: 1)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: primaryOrange, width: 2)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: alertRed, width: 1)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: alertRed, width: 2)),
          labelStyle: GoogleFonts.inter(color: textMediumEmphasisDark, fontSize: 16, fontWeight: FontWeight.w400),
          hintStyle: GoogleFonts.inter(color: textDisabledDark, fontSize: 16, fontWeight: FontWeight.w400),
          prefixIconColor: textMediumEmphasisDark,
          suffixIconColor: textMediumEmphasisDark),

      // Switch Theme - Dark mode
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryOrange;
        }
        return dividerDark;
      }), trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryOrange.withValues(alpha: 0.3);
        }
        return dividerDark.withValues(alpha: 0.5);
      })),

      // Checkbox Theme - Dark mode
      checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return primaryOrange;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(textCharcoal),
          side: const BorderSide(color: dividerDark, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),

      // Radio Theme - Dark mode
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryOrange;
        }
        return dividerDark;
      })),

      // Progress Indicator Theme - Dark mode
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryOrange, linearTrackColor: dividerDark, circularTrackColor: dividerDark),

      // Slider Theme - Dark mode
      sliderTheme: SliderThemeData(activeTrackColor: primaryOrange, thumbColor: primaryOrange, overlayColor: primaryOrange.withValues(alpha: 0.2), inactiveTrackColor: dividerDark, valueIndicatorColor: primaryOrange, valueIndicatorTextStyle: GoogleFonts.robotoMono(color: textCharcoal, fontSize: 12, fontWeight: FontWeight.w500)),

      // Tab Bar Theme - Dark mode
      tabBarTheme: TabBarThemeData(labelColor: primaryOrange, unselectedLabelColor: textMediumEmphasisDark, indicatorColor: primaryOrange, indicatorSize: TabBarIndicatorSize.label, labelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600), unselectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400)),

      // Tooltip Theme - Dark mode
      tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: pureWhite.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8)), textStyle: GoogleFonts.inter(color: textCharcoal, fontSize: 12, fontWeight: FontWeight.w400), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),

      // SnackBar Theme - Dark mode
      snackBarTheme: SnackBarThemeData(backgroundColor: pureWhite, contentTextStyle: GoogleFonts.inter(color: textCharcoal, fontSize: 14, fontWeight: FontWeight.w400), actionTextColor: primaryOrange, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),

      // Expansion Tile Theme - Dark mode
      expansionTileTheme: ExpansionTileThemeData(backgroundColor: backgroundDark, collapsedBackgroundColor: surfaceDark, iconColor: primaryOrange, collapsedIconColor: textMediumEmphasisDark, textColor: textHighEmphasisDark, collapsedTextColor: textHighEmphasisDark, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),

      // List Tile Theme - Dark mode
      listTileTheme: ListTileThemeData(contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), tileColor: surfaceDark, selectedTileColor: primaryOrange.withValues(alpha: 0.1), iconColor: textMediumEmphasisDark, selectedColor: primaryOrange, textColor: textHighEmphasisDark),

      // Chip Theme - Dark mode
      chipTheme: ChipThemeData(backgroundColor: backgroundDark, selectedColor: primaryOrange.withValues(alpha: 0.2), disabledColor: dividerDark, labelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: textHighEmphasisDark), secondaryLabelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: primaryOrange), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), dialogTheme: DialogThemeData(backgroundColor: cardDark));

  /// Helper method to build text theme based on brightness using Inter font
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textHighEmphasis =
        isLight ? textHighEmphasisLight : textHighEmphasisDark;
    final Color textMediumEmphasis =
        isLight ? textMediumEmphasisLight : textMediumEmphasisDark;
    final Color textDisabled = isLight ? textDisabledLight : textDisabledDark;

    return TextTheme(
        // Display styles - Large headings
        displayLarge: GoogleFonts.inter(
            fontSize: 57,
            fontWeight: FontWeight.w700,
            color: textHighEmphasis,
            letterSpacing: -0.25,
            height: 1.12),
        displayMedium: GoogleFonts.inter(
            fontSize: 45,
            fontWeight: FontWeight.w700,
            color: textHighEmphasis,
            letterSpacing: 0,
            height: 1.16),
        displaySmall: GoogleFonts.inter(
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: textHighEmphasis,
            letterSpacing: 0,
            height: 1.22),

        // Headline styles - Section headers and canteen names
        headlineLarge: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: textHighEmphasis,
            letterSpacing: 0,
            height: 1.25),
        headlineMedium: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: textHighEmphasis,
            letterSpacing: 0,
            height: 1.29),
        headlineSmall: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: textHighEmphasis,
            letterSpacing: 0,
            height: 1.33),

        // Title styles - Food item names and important labels
        titleLarge: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textHighEmphasis,
            letterSpacing: 0,
            height: 1.27),
        titleMedium: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textHighEmphasis,
            letterSpacing: 0.15,
            height: 1.50),
        titleSmall: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textHighEmphasis,
            letterSpacing: 0.1,
            height: 1.43),

        // Body styles - Menu descriptions and order details
        bodyLarge: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textHighEmphasis,
            letterSpacing: 0.5,
            height: 1.50),
        bodyMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textHighEmphasis,
            letterSpacing: 0.25,
            height: 1.43),
        bodySmall: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textMediumEmphasis,
            letterSpacing: 0.4,
            height: 1.33),

        // Label styles - Buttons and secondary information
        labelLarge: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textHighEmphasis,
            letterSpacing: 0.1,
            height: 1.43),
        labelMedium: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textMediumEmphasis,
            letterSpacing: 0.5,
            height: 1.33),
        labelSmall: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: textDisabled,
            letterSpacing: 0.5,
            height: 1.45));
  }


  // Color specifications based on design theme
  static const Color primaryLight =
      Color(0xFFFF6B35); // Warm orange for CTAs and active states
  static const Color secondaryLight =
      Color(0xFF2C3E50); // Deep blue-gray for headers and important text
  static const Color backgroundLight =
      Color(0xFFFFFFFF); // Pure white for maximum content clarity
  static const Color surfaceLight =
      Color(0xFFF8F9FA); // Subtle gray for card backgrounds
  static const Color successLight =
      Color(0xFF27AE60); // Clear green for order confirmations
  static const Color warningLight =
      Color(0xFFF39C12); // Amber for pickup time alerts
  static const Color errorLight =
      Color(0xFFE74C3C); // Standard red for validation errors
  static const Color textPrimaryLight =
      Color(0xFF2C3E50); // High contrast for body text
  static const Color textSecondaryLight =
      Color(0xFF7F8C8D); // Medium gray for supporting information
  static const Color accentLight =
      Color(0xFF3498DB); // Bright blue for links and AI chat elements

  // Dark theme colors (adapted from light theme)
  static const Color primaryDark = Color(0xFFFF6B35);
  static const Color secondaryDark = Color(0xFF34495E);
  // static const Color backgroundDark = Color(0xFF121212);
  // static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color successDark = Color(0xFF27AE60);
  static const Color warningDark = Color(0xFFF39C12);
  static const Color errorDark = Color(0xFFE74C3C);
  static const Color textPrimaryDark = Color(0xFFECF0F1);
  static const Color textSecondaryDark = Color(0xFFBDC3C7);
  static const Color accentDark = Color(0xFF3498DB);

  // Additional colors for theme consistency
  static const Color cardLight = Color(0xFFF8F9FA);
  // static const Color cardDark = Color(0xFF2D2D2D);
  static const Color dialogLight = Color(0xFFFFFFFF);
  static const Color dialogDark = Color(0xFF2D2D2D);
  // static const Color shadowLight = Color(0x0F000000);
  // static const Color shadowDark = Color(0x1FFFFFFF);
  static const Color dividerLight = Color(0xFFE1E8ED);
  // static const Color dividerDark = Color(0xFF34495E);

  /// Light theme
  // static ThemeData lightTheme = ThemeData(
  //   brightness: Brightness.light,
  //   colorScheme: ColorScheme(
  //     brightness: Brightness.light,
  //     primary: primaryLight,
  //     onPrimary: Colors.white,
  //     primaryContainer: primaryLight.withValues(alpha: 0.1),
  //     onPrimaryContainer: primaryLight,
  //     secondary: secondaryLight,
  //     onSecondary: Colors.white,
  //     secondaryContainer: secondaryLight.withValues(alpha: 0.1),
  //     onSecondaryContainer: secondaryLight,
  //     tertiary: accentLight,
  //     onTertiary: Colors.white,
  //     tertiaryContainer: accentLight.withValues(alpha: 0.1),
  //     onTertiaryContainer: accentLight,
  //     error: errorLight,
  //     onError: Colors.white,
  //     surface: surfaceLight,
  //     onSurface: textPrimaryLight,
  //     onSurfaceVariant: textSecondaryLight,
  //     outline: dividerLight,
  //     outlineVariant: dividerLight.withValues(alpha: 0.5),
  //     shadow: shadowLight,
  //     scrim: Colors.black.withValues(alpha: 0.5),
  //     inverseSurface: surfaceDark,
  //     onInverseSurface: textPrimaryDark,
  //     inversePrimary: primaryDark,
  //   ),
  //   scaffoldBackgroundColor: backgroundLight,
  //   cardColor: cardLight,
  //   dividerColor: dividerLight,
  //   appBarTheme: AppBarTheme(
  //     backgroundColor: backgroundLight,
  //     foregroundColor: textPrimaryLight,
  //     elevation: 0,
  //     shadowColor: shadowLight,
  //     surfaceTintColor: Colors.transparent,
  //     titleTextStyle: GoogleFonts.inter(
  //       fontSize: 20,
  //       fontWeight: FontWeight.w600,
  //       color: textPrimaryLight,
  //     ),
  //   ),
  //   cardTheme: CardThemeData(
  //     color: cardLight,
  //     elevation: 2.0,
  //     shadowColor: shadowLight,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //     ),
  //     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //   ),
  //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     backgroundColor: backgroundLight,
  //     selectedItemColor: primaryLight,
  //     unselectedItemColor: textSecondaryLight,
  //     elevation: 8,
  //     type: BottomNavigationBarType.fixed,
  //     selectedLabelStyle: GoogleFonts.inter(
  //       fontSize: 12,
  //       fontWeight: FontWeight.w500,
  //     ),
  //     unselectedLabelStyle: GoogleFonts.inter(
  //       fontSize: 12,
  //       fontWeight: FontWeight.w400,
  //     ),
  //   ),
  //   floatingActionButtonTheme: FloatingActionButtonThemeData(
  //     backgroundColor: primaryLight,
  //     foregroundColor: Colors.white,
  //     elevation: 4,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(16.0),
  //     ),
  //   ),
  //   elevatedButtonTheme: ElevatedButtonThemeData(
  //     style: ElevatedButton.styleFrom(
  //       foregroundColor: Colors.white,
  //       backgroundColor: primaryLight,
  //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  //       elevation: 2,
  //       shadowColor: shadowLight,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12.0),
  //       ),
  //       textStyle: GoogleFonts.inter(
  //         fontSize: 16,
  //         fontWeight: FontWeight.w600,
  //       ),
  //     ),
  //   ),
  //   outlinedButtonTheme: OutlinedButtonThemeData(
  //     style: OutlinedButton.styleFrom(
  //       foregroundColor: primaryLight,
  //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  //       side: const BorderSide(color: primaryLight, width: 1),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12.0),
  //       ),
  //       textStyle: GoogleFonts.inter(
  //         fontSize: 16,
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ),
  //   ),
  //   textButtonTheme: TextButtonThemeData(
  //     style: TextButton.styleFrom(
  //       foregroundColor: primaryLight,
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8.0),
  //       ),
  //       textStyle: GoogleFonts.inter(
  //         fontSize: 16,
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ),
  //   ),
  //   textTheme: _buildTextTheme(isLight: true),
  //   inputDecorationTheme: InputDecorationTheme(
  //     fillColor: backgroundLight,
  //     filled: true,
  //     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  //     border: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //       borderSide: const BorderSide(color: dividerLight, width: 1),
  //     ),
  //     enabledBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //       borderSide: const BorderSide(color: dividerLight, width: 1),
  //     ),
  //     focusedBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //       borderSide: const BorderSide(color: primaryLight, width: 2),
  //     ),
  //     errorBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //       borderSide: const BorderSide(color: errorLight, width: 1),
  //     ),
  //     focusedErrorBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //       borderSide: const BorderSide(color: errorLight, width: 2),
  //     ),
  //     labelStyle: GoogleFonts.inter(
  //       color: textSecondaryLight,
  //       fontSize: 16,
  //       fontWeight: FontWeight.w400,
  //     ),
  //     hintStyle: GoogleFonts.inter(
  //       color: textSecondaryLight,
  //       fontSize: 16,
  //       fontWeight: FontWeight.w400,
  //     ),
  //     errorStyle: GoogleFonts.inter(
  //       color: errorLight,
  //       fontSize: 12,
  //       fontWeight: FontWeight.w400,
  //     ),
  //   ),
  //   switchTheme: SwitchThemeData(
  //     thumbColor: WidgetStateProperty.resolveWith((states) {
  //       if (states.contains(WidgetState.selected)) {
  //         return primaryLight;
  //       }
  //       return Colors.grey[300];
  //     }),
  //     trackColor: WidgetStateProperty.resolveWith((states) {
  //       if (states.contains(WidgetState.selected)) {
  //         return primaryLight.withValues(alpha: 0.3);
  //       }
  //       return Colors.grey[200];
  //     }),
  //   ),
  //   checkboxTheme: CheckboxThemeData(
  //     fillColor: WidgetStateProperty.resolveWith((states) {
  //       if (states.contains(WidgetState.selected)) {
  //         return primaryLight;
  //       }
  //       return Colors.transparent;
  //     }),
  //     checkColor: WidgetStateProperty.all(Colors.white),
  //     side: const BorderSide(color: dividerLight, width: 2),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(4),
  //     ),
  //   ),
  //   radioTheme: RadioThemeData(
  //     fillColor: WidgetStateProperty.resolveWith((states) {
  //       if (states.contains(WidgetState.selected)) {
  //         return primaryLight;
  //       }
  //       return textSecondaryLight;
  //     }),
  //   ),
  //   progressIndicatorTheme: const ProgressIndicatorThemeData(
  //     color: primaryLight,
  //     linearTrackColor: dividerLight,
  //   ),
  //   sliderTheme: SliderThemeData(
  //     activeTrackColor: primaryLight,
  //     thumbColor: primaryLight,
  //     overlayColor: primaryLight.withValues(alpha: 0.2),
  //     inactiveTrackColor: dividerLight,
  //     trackHeight: 4,
  //   ),
  //   tabBarTheme: TabBarThemeData(
  //     labelColor: primaryLight,
  //     unselectedLabelColor: textSecondaryLight,
  //     indicatorColor: primaryLight,
  //     indicatorSize: TabBarIndicatorSize.label,
  //     labelStyle: GoogleFonts.inter(
  //       fontSize: 16,
  //       fontWeight: FontWeight.w600,
  //     ),
  //     unselectedLabelStyle: GoogleFonts.inter(
  //       fontSize: 16,
  //       fontWeight: FontWeight.w400,
  //     ),
  //   ),
  //   tooltipTheme: TooltipThemeData(
  //     decoration: BoxDecoration(
  //       color: textPrimaryLight.withValues(alpha: 0.9),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     textStyle: GoogleFonts.inter(
  //       color: Colors.white,
  //       fontSize: 14,
  //       fontWeight: FontWeight.w400,
  //     ),
  //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //   ),
  //   snackBarTheme: SnackBarThemeData(
  //     backgroundColor: textPrimaryLight,
  //     contentTextStyle: GoogleFonts.inter(
  //       color: Colors.white,
  //       fontSize: 14,
  //       fontWeight: FontWeight.w400,
  //     ),
  //     actionTextColor: primaryLight,
  //     behavior: SnackBarBehavior.floating,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //     ),
  //     elevation: 4,
  //   ),
  //   bottomSheetTheme: const BottomSheetThemeData(
  //     backgroundColor: backgroundLight,
  //     elevation: 8,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //   ), dialogTheme: DialogThemeData(backgroundColor: dialogLight),
  // );

  /// Dark theme
  // static ThemeData darkTheme = ThemeData(
  //   brightness: Brightness.dark,
  //   colorScheme: ColorScheme(
  //     brightness: Brightness.dark,
  //     primary: primaryDark,
  //     onPrimary: Colors.white,
  //     primaryContainer: primaryDark.withValues(alpha: 0.2),
  //     onPrimaryContainer: primaryDark,
  //     secondary: secondaryDark,
  //     onSecondary: Colors.white,
  //     secondaryContainer: secondaryDark.withValues(alpha: 0.2),
  //     onSecondaryContainer: secondaryDark,
  //     tertiary: accentDark,
  //     onTertiary: Colors.white,
  //     tertiaryContainer: accentDark.withValues(alpha: 0.2),
  //     onTertiaryContainer: accentDark,
  //     error: errorDark,
  //     onError: Colors.white,
  //     surface: surfaceDark,
  //     onSurface: textPrimaryDark,
  //     onSurfaceVariant: textSecondaryDark,
  //     outline: dividerDark,
  //     outlineVariant: dividerDark.withValues(alpha: 0.5),
  //     shadow: shadowDark,
  //     scrim: Colors.black.withValues(alpha: 0.7),
  //     inverseSurface: surfaceLight,
  //     onInverseSurface: textPrimaryLight,
  //     inversePrimary: primaryLight,
  //   ),
  //   scaffoldBackgroundColor: backgroundDark,
  //   cardColor: cardDark,
  //   dividerColor: dividerDark,
  //   appBarTheme: AppBarTheme(
  //     backgroundColor: backgroundDark,
  //     foregroundColor: textPrimaryDark,
  //     elevation: 0,
  //     shadowColor: shadowDark,
  //     surfaceTintColor: Colors.transparent,
  //     titleTextStyle: GoogleFonts.inter(
  //       fontSize: 20,
  //       fontWeight: FontWeight.w600,
  //       color: textPrimaryDark,
  //     ),
  //   ),
  //   cardTheme: CardThemeData(
  //     color: cardDark,
  //     elevation: 2.0,
  //     shadowColor: shadowDark,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //     ),
  //     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //   ),
  //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     backgroundColor: backgroundDark,
  //     selectedItemColor: primaryDark,
  //     unselectedItemColor: textSecondaryDark,
  //     elevation: 8,
  //     type: BottomNavigationBarType.fixed,
  //     selectedLabelStyle: GoogleFonts.inter(
  //       fontSize: 12,
  //       fontWeight: FontWeight.w500,
  //     ),
  //     unselectedLabelStyle: GoogleFonts.inter(
  //       fontSize: 12,
  //       fontWeight: FontWeight.w400,
  //     ),
  //   ),
  //   floatingActionButtonTheme: FloatingActionButtonThemeData(
  //     backgroundColor: primaryDark,
  //     foregroundColor: Colors.white,
  //     elevation: 4,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(16.0),
  //     ),
  //   ),
  //   elevatedButtonTheme: ElevatedButtonThemeData(
  //     style: ElevatedButton.styleFrom(
  //       foregroundColor: Colors.white,
  //       backgroundColor: primaryDark,
  //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  //       elevation: 2,
  //       shadowColor: shadowDark,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12.0),
  //       ),
  //       textStyle: GoogleFonts.inter(
  //         fontSize: 16,
  //         fontWeight: FontWeight.w600,
  //       ),
  //     ),
  //   ),
  //   outlinedButtonTheme: OutlinedButtonThemeData(
  //     style: OutlinedButton.styleFrom(
  //       foregroundColor: primaryDark,
  //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  //       side: const BorderSide(color: primaryDark, width: 1),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12.0),
  //       ),
  //       textStyle: GoogleFonts.inter(
  //         fontSize: 16,
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ),
  //   ),
  //   textButtonTheme: TextButtonThemeData(
  //     style: TextButton.styleFrom(
  //       foregroundColor: primaryDark,
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8.0),
  //       ),
  //       textStyle: GoogleFonts.inter(
  //         fontSize: 16,
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ),
  //   ),
  //   textTheme: _buildTextTheme(isLight: false),
  //   inputDecorationTheme: InputDecorationTheme(
  //     fillColor: surfaceDark,
  //     filled: true,
  //     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  //     border: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //       borderSide: const BorderSide(color: dividerDark, width: 1),
  //     ),
  //     enabledBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //       borderSide: const BorderSide(color: dividerDark, width: 1),
  //     ),
  //     focusedBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //       borderSide: const BorderSide(color: primaryDark, width: 2),
  //     ),
  //     errorBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //       borderSide: const BorderSide(color: errorDark, width: 1),
  //     ),
  //     focusedErrorBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //       borderSide: const BorderSide(color: errorDark, width: 2),
  //     ),
  //     labelStyle: GoogleFonts.inter(
  //       color: textSecondaryDark,
  //       fontSize: 16,
  //       fontWeight: FontWeight.w400,
  //     ),
  //     hintStyle: GoogleFonts.inter(
  //       color: textSecondaryDark,
  //       fontSize: 16,
  //       fontWeight: FontWeight.w400,
  //     ),
  //     errorStyle: GoogleFonts.inter(
  //       color: errorDark,
  //       fontSize: 12,
  //       fontWeight: FontWeight.w400,
  //     ),
  //   ),
  //   switchTheme: SwitchThemeData(
  //     thumbColor: WidgetStateProperty.resolveWith((states) {
  //       if (states.contains(WidgetState.selected)) {
  //         return primaryDark;
  //       }
  //       return Colors.grey[600];
  //     }),
  //     trackColor: WidgetStateProperty.resolveWith((states) {
  //       if (states.contains(WidgetState.selected)) {
  //         return primaryDark.withValues(alpha: 0.3);
  //       }
  //       return Colors.grey[800];
  //     }),
  //   ),
  //   checkboxTheme: CheckboxThemeData(
  //     fillColor: WidgetStateProperty.resolveWith((states) {
  //       if (states.contains(WidgetState.selected)) {
  //         return primaryDark;
  //       }
  //       return Colors.transparent;
  //     }),
  //     checkColor: WidgetStateProperty.all(Colors.white),
  //     side: const BorderSide(color: dividerDark, width: 2),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(4),
  //     ),
  //   ),
  //   radioTheme: RadioThemeData(
  //     fillColor: WidgetStateProperty.resolveWith((states) {
  //       if (states.contains(WidgetState.selected)) {
  //         return primaryDark;
  //       }
  //       return textSecondaryDark;
  //     }),
  //   ),
  //   progressIndicatorTheme: const ProgressIndicatorThemeData(
  //     color: primaryDark,
  //     linearTrackColor: dividerDark,
  //   ),
  //   sliderTheme: SliderThemeData(
  //     activeTrackColor: primaryDark,
  //     thumbColor: primaryDark,
  //     overlayColor: primaryDark.withValues(alpha: 0.2),
  //     inactiveTrackColor: dividerDark,
  //     trackHeight: 4,
  //   ),
  //   tabBarTheme: TabBarThemeData(
  //     labelColor: primaryDark,
  //     unselectedLabelColor: textSecondaryDark,
  //     indicatorColor: primaryDark,
  //     indicatorSize: TabBarIndicatorSize.label,
  //     labelStyle: GoogleFonts.inter(
  //       fontSize: 16,
  //       fontWeight: FontWeight.w600,
  //     ),
  //     unselectedLabelStyle: GoogleFonts.inter(
  //       fontSize: 16,
  //       fontWeight: FontWeight.w400,
  //     ),
  //   ),
  //   tooltipTheme: TooltipThemeData(
  //     decoration: BoxDecoration(
  //       color: textPrimaryDark.withValues(alpha: 0.9),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     textStyle: GoogleFonts.inter(
  //       color: backgroundDark,
  //       fontSize: 14,
  //       fontWeight: FontWeight.w400,
  //     ),
  //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //   ),
  //   snackBarTheme: SnackBarThemeData(
  //     backgroundColor: textPrimaryDark,
  //     contentTextStyle: GoogleFonts.inter(
  //       color: backgroundDark,
  //       fontSize: 14,
  //       fontWeight: FontWeight.w400,
  //     ),
  //     actionTextColor: primaryDark,
  //     behavior: SnackBarBehavior.floating,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //     ),
  //     elevation: 4,
  //   ),
  //   bottomSheetTheme: const BottomSheetThemeData(
  //     backgroundColor: backgroundDark,
  //     elevation: 8,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //   ), dialogTheme: DialogThemeData(backgroundColor: dialogDark),
  // );

  

  /// Helper method to get monospace text style for data display
  static TextStyle getMonospaceStyle({
    required bool isLight,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    final Color textColor = isLight ? textPrimaryLight : textPrimaryDark;
    return GoogleFonts.robotoMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: textColor,
      letterSpacing: 0,
    );
  }

  /// Helper method to get success color based on theme
  static Color getSuccessColor(bool isLight) {
    return isLight ? successLight : successDark;
  }

  /// Helper method to get warning color based on theme
  static Color getWarningColor(bool isLight) {
    return isLight ? warningLight : warningDark;
  }

  /// Helper method to get accent color based on theme
  static Color getAccentColor(bool isLight) {
    return isLight ? accentLight : accentDark;
  }
}
