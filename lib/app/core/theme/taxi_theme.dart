import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaxiTheme {
  static const Color primary = Color(0xFFFFCC00); // Taxi Yellow
  static const Color secondary = Color(0xFF1A1A2F); // Dark Blue/Black
  static const Color accent = Color(0xFF00C853); // Green for success
  static const Color error = Color(0xFFD32F2F);
  static const Color surface = Colors.white;
  static const Color background = Color(0xFFF8F9FA);
  static const Color textDark = Color(0xFF1A1A2F);
  static const Color textMuted = Color(0xFF888888);

  static TextStyle get headingLarge => GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textDark,
  );

  static TextStyle get headingMedium => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textDark,
  );

  static TextStyle get bodyLarge =>
      GoogleFonts.poppins(fontSize: 16, color: textDark);

  static TextStyle get bodyMedium =>
      GoogleFonts.poppins(fontSize: 14, color: textMuted);

  static ThemeData get theme => ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: background,
    colorScheme: ColorScheme.light(
      primary: primary,
      secondary: secondary,
      surface: surface,
      // background: background, // Deprecated, using surface covers it mostly or handle via scaffoldBackgroundColor
      error: error,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: surface,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.black, // Text color on yellow
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      hintStyle: GoogleFonts.poppins(color: textMuted.withValues(alpha: 0.5)),
    ),
  );
}
