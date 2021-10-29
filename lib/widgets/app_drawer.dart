import 'package:flutter/material.dart';
import 'package:nazareth_upload_app/daily_inspiration.dart';
import 'package:nazareth_upload_app/daily_verse.dart';
import 'package:nazareth_upload_app/home.dart';

class AppDrawer extends StatelessWidget {
  final Function onIndexChanged;

  const AppDrawer(this.onIndexChanged, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/pcg_main_house.jpeg"),
                    fit: BoxFit.cover)),
            child: Container()),
        Container(
          color: selectedIndex == 0 ? Colors.blue.withOpacity(0.15) : null,
          child: ListTile(
            leading: const Icon(Icons.announcement),
            title: const Text("Announcement"),
            selected: selectedIndex == 0,
            onTap: () {
              Navigator.pop(context);
              onIndexChanged(0);
            },
          ),
        ),
        Container(
          color: selectedIndex == 1 ? Colors.blue.withOpacity(0.15) : null,
          child: ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text("Daily Verse"),
            selected: selectedIndex == 1,
            onTap: () {
              Navigator.pop(context);
              onIndexChanged(1);
            },
          ),
        ),
        Container(
            color: selectedIndex == 2 ? Colors.blue.withOpacity(0.15) : null,
            child: ListTile(
              leading: const Icon(Icons.info),
              title: const Text("Daily Inspiration"),
              selected: selectedIndex == 2,
              onTap: () {
                Navigator.pop(context);
                onIndexChanged(2);
              },
            )),
      ],
    ));
  }
}
