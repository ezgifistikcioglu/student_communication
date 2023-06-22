import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication/widgets/pages/splash/splash_screen.dart';

import 'product/constants/app_constants.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ApplicationConstants.homePageText,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: normalPurple,
          foregroundColor: Colors.black,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(200, 20),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: normalPurple,
            foregroundColor: Colors.black,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
            labelStyle: const TextStyle(color: Colors.black54),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: normalPurple),
            ),
            suffixIconColor: normalPurple),
      ),
      home: const SplashScreen(),
    );
  }
}
