import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nazareth_upload_app/daily_inspiration.dart';
import 'package:nazareth_upload_app/daily_verse.dart';
import 'package:nazareth_upload_app/widgets/app_drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;
var _textController = TextEditingController();
int selectedIndex = 0;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Nazareth Admin App")),
        drawer: AppDrawer((int index) {
          setState(() {
            selectedIndex = index;
          });
        }),
        body: Builder(builder: (context) {
          if (selectedIndex == 0) {
            return homeWidget();
          }
          if (selectedIndex == 1) {
            return const DailyVerse();
          }
          if (selectedIndex == 2) {
            return const DailyInspiration();
          }
          return Container();
        }));
  }

  Widget homeWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "Make Announcement",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                  hintText: "Enter text...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: 1))),
              minLines: null,
              maxLines: 10,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 150,
            height: 50,
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                _upload(_textController.text.toString().trim());
              },
              child: const Text(
                "UPLOAD",
                style: TextStyle(fontSize: 16),
              ),
              // style: ButtonStyle(
              //   elevation: MaterialStateProperty

              // ),
            ),
          )
        ],
      ),
    );
  }

  _upload(String message) {
    if (message.isNotEmpty) {
      firestore
          .collection("announcements")
          .add({"message": message, "date": DateTime.now().toString()}).then(
              (value) {
        _textController.text = "";
        Fluttertoast.showToast(
            msg: "Uploaded Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM);
      }).catchError((error) => print("Error: $error"));
    }
  }
}
