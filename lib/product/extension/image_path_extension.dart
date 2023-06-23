import 'package:flutter/material.dart';

enum ImagePaths { ic_google }

extension ImagePathsExtension on ImagePaths {
  String pathImage() {
    return 'assets/authentication/$name.png';
  }

  Widget toWidget({double height = 27}) {
    return Image.asset(pathImage(), height: height);
  }
}
