import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/utils/theme/app_colors.dart';
import 'package:movie_app/view/module/home/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 3300), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()), // Replace with your main screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText('Movie App', textStyle: GoogleFonts.outfit(textStyle: const TextStyle(color: Colors.red, fontSize: 40, fontWeight: FontWeight.w700))),
          ],
          isRepeatingAnimation: true,
        ),
      ),
    );
  }
}
