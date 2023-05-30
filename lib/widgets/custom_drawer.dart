import 'package:flutter/material.dart';
import 'package:student_communication/widgets/custom_list_tile.dart';
import 'package:student_communication/widgets/pages/students.dart';

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
        children: const <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.text_fields_rounded,
                    color: Colors.white,
                    size: 100.0,
                  ),
                  Text(
                    "Student Name",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ],
              ),
            ),
          ),
          NewListTile(
            leadingIcon: Icon(Icons.home),
            textTitle: Text('Home Page'),
            // onTap: () => Navigator.pushNamed(context, "/"),
          ),
          NewListTile(
            textTitle: Text('Students'),
            //onTap: () => Navigator.pushNamed(context, "/students"),
          ),
          NewListTile(
            leadingIcon: Icon(Icons.attribution_outlined),
            textTitle: Text('Teachers'),
            //onTap: () => Navigator.push(context),
          ),
          NewListTile(
            leadingIcon: Icon(Icons.message_outlined),
            textTitle: Text('Messages'),
            //onTap: () => Navigator.pushNamed(context, "/messages"),
          ),
        ],
      ),
    );
  }
}
