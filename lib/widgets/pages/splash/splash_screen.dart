import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_communication/product/constants/app_constants.dart';

import '../app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return const MyHomePage();
      },
    ));
  }
}
