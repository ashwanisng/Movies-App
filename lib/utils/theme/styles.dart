import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/utils/theme/app_colors.dart';

class Styles {
  Styles._privateConstructor();

  static TextStyle tsWhiteRegular18 = GoogleFonts.outfit(
    textStyle: const TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w400,
      fontSize: 18.0,
    ),
  );

  static TextStyle tsPrimaryColorRegular18 = GoogleFonts.outfit(
    textStyle: const TextStyle(
      color: AppColors.primaryColor,
      fontWeight: FontWeight.w400,
      fontSize: 18.0,
    ),
  );

  static TextStyle h4 = GoogleFonts.outfit(
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
  );

  static TextStyle h5 = GoogleFonts.outfit(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
  );

  static TextStyle h6 = GoogleFonts.outfit(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
  );

  static TextStyle h7 = GoogleFonts.outfit(
    textStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
  );

  static TextStyle tsLightBlueRegular13 = GoogleFonts.outfit(
    textStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
  );
}
