import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackfood_app/app/data/constants/app_colors.dart';
import 'package:stackfood_app/app/data/constants/app_strings.dart';
import 'package:stackfood_app/app/modules/home/controllers/config_controller.dart';
import 'package:stackfood_app/app/modules/home/controllers/home_controller.dart';
import 'package:stackfood_app/app/modules/home/views/home_page.dart';

void main() {
  // Initialize GetX controllers
  Get.put(ConfigController());
  Get.put(HomeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textPrimary),
          titleTextStyle: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
        ),
      ),
      home: const HomePage(),
    );
  }
}
