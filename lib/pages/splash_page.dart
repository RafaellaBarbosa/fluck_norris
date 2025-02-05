import 'dart:async';

import 'package:fluck_norris/core/utils/app_colors.dart';
import 'package:fluck_norris/pages/categories_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isLogoAnimated = false;

  static const Duration _animationDuration = Duration(milliseconds: 500);
  static const Duration _navigationDelay = Duration(seconds: 10);

  @override
  void initState() {
    super.initState();
    Timer(_animationDuration, () {
      setState(() {
        _isLogoAnimated = true;
      });
    });
    Timer(_navigationDelay, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CategoriesPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.azulNoturno,
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          height: _isLogoAnimated ? 250 : 50,
          width: _isLogoAnimated ? 250 : 50,
          child: LogoWidget(),
        ),
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/chuck_norris_logo.png');
  }
}
