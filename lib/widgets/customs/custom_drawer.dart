import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_communication/product/constants/app_constants.dart';
import 'package:student_communication/utilities/google_sign_out.dart';
import 'package:student_communication/widgets/customs/custom_list_tile.dart';
import 'package:student_communication/widgets/pages/app.dart';
import 'package:student_communication/widgets/pages/message/messages.dart';
import 'package:student_communication/widgets/pages/splash/splash_screen.dart';
import 'package:student_communication/widgets/pages/student/students.dart';
import 'package:student_communication/widgets/pages/teacher/teachers.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Future<Uint8List?>? _userPictureFuture;

  @override
  void initState() {
    super.initState();
    _userPictureFuture = _userPictureDownload();
  }

  Future<Uint8List?> _userPictureDownload() async {
    final documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final userRecMapData = documentSnapshot.data();
    if (userRecMapData == null) return null;
    if (userRecMapData.containsKey('userPictureRef')) {
      Uint8List? uint8list = await FirebaseStorage.instance
          .ref(userRecMapData['userPictureRef'])
          .getData();
      return uint8list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: normalPurple,
            ),
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.text_fields_rounded,
                    color: Colors.white,
                    size: getMinWidth(context),
                  ),
                  Column(
                    children: [
                      Text(
                        firebaseGetCurrentUser().displayName!,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 25.0),
                      ),
                      sizedBoxFive,
                      InkWell(
                        onTap: () async {
                          XFile? xFile = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (xFile == null) return;
                          final imagePath = xFile.path;
                          final userPictureRef = FirebaseStorage.instance
                              .ref('userPicture')
                              .child('$uid.jpg');
                          await userPictureRef.putFile(File(imagePath));
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .update(
                                  {'userPictureRef': userPictureRef.fullPath});
                          setState(() {
                            _userPictureFuture = _userPictureDownload();
                          });
                        },
                        child: FutureBuilder<Uint8List?>(
                            future: _userPictureFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data != null) {
                                final pictureInMemory = snapshot.data!;
                                return CircleAvatar(
                                  backgroundImage: MemoryImage(pictureInMemory),
                                );
                              }
                              return const CircleAvatar(
                                child: Text('data'),
                              );
                            }),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          NewListTile(
            leadingIcon: const Icon(Icons.home),
            textTitle: const Text(ApplicationConstants.homeText),
            onTap: () => navigatorToPage(context, const MyHomePage()),
          ),
          NewListTile(
            textTitle: const Text(ApplicationConstants.studentsPageText),
            onTap: () => navigatorToPage(context, const Students()),
          ),
          NewListTile(
            leadingIcon: const Icon(Icons.attribution_outlined),
            textTitle: const Text(ApplicationConstants.teachersPageText),
            onTap: () => navigatorToPage(context, const Teachers()),
          ),
          NewListTile(
            leadingIcon: const Icon(Icons.message_outlined),
            textTitle: const Text(ApplicationConstants.messagePageText),
            onTap: () => navigatorToPage(context, const Messages()),
          ),
          NewListTile(
            leadingIcon: const Icon(Icons.logout_outlined),
            textTitle: const Text(ApplicationConstants.logoutText),
            onTap: () async {
              await signOutWithGoogle();
              if (!mounted) return;
              navigatorToPage(context, const SplashScreen());
            },
          ),
        ],
      ),
    );
  }

  void navigatorToPage(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ));
  }
}
