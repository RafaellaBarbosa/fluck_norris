import 'package:fluck_norris/pages/categories_page.dart';
import 'package:flutter/material.dart';

import 'core/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xff202435),
          ),
          useMaterial3: true,
          fontFamily: 'Courier',
          scaffoldBackgroundColor: AppColors.azulNoturno,
        ),
        home: const CategoriesPage());
  }
}
