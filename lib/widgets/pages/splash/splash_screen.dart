import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_communication/product/extension/image_path_extension.dart';
import 'package:student_communication/utilities/google_sign_in.dart';

import '../app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirebaseInitialized = false;
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isFirebaseInitialized
            ? IconButton(
                onPressed: () async {
                  await signInWithGoogle();
                  // get authentiication user uid
                  String uid = FirebaseAuth.instance.currentUser!.uid;
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .set(
                    {
                      'userLoggedIn': true,
                      'lastEntryDate':
                          FieldValue.serverTimestamp(), // get server time
                    },
                    SetOptions(merge: true),
                  );
                  goToHomePage();
                },
                icon: ImagePaths.ic_google.toWidget(),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    setState(() {
      isFirebaseInitialized = true;
    });
    if (FirebaseAuth.instance.currentUser != null) {
      goToHomePage();
    }
  }

  void goToHomePage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return const MyHomePage();
      },
    ));
  }
}
