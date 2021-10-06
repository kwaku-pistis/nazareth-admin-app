import 'package:flutter/material.dart';
import 'package:nazareth_upload_app/daily_verse.dart';
import 'package:nazareth_upload_app/home.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
            decoration: BoxDecoration(color: Colors.red),
            child: Text("Nazareth Presby",
                style: TextStyle(color: Colors.white, fontSize: 20))),
        ListTile(
          leading: const Icon(Icons.announcement),
          title: const Text("Announcement"),
          onTap: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
            // Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: const Icon(Icons.menu_book),
          title: const Text("Daily Verse"),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const DailyVerse()));
            // Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text("Daily Inspiration"),
          onTap: () {
            // Navigator.of(context).pop();
          },
        ),
      ],
    ));
  }
}
