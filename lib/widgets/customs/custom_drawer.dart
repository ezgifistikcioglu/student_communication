import 'package:flutter/material.dart';
import 'package:student_communication/product/constants/app_constants.dart';
import 'package:student_communication/widgets/customs/custom_list_tile.dart';
import 'package:student_communication/widgets/pages/app.dart';
import 'package:student_communication/widgets/pages/message/messages.dart';
import 'package:student_communication/widgets/pages/student/students.dart';
import 'package:student_communication/widgets/pages/teacher/teachers.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
                  const Text(
                    ApplicationConstants.homePageText,
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
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
