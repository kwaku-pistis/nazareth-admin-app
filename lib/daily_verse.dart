import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nazareth_upload_app/widgets/app_drawer.dart';

class DailyVerse extends StatefulWidget {
  const DailyVerse({Key? key}) : super(key: key);

  @override
  _DailyVerseState createState() => _DailyVerseState();
}

final FirebaseFirestore firestore = FirebaseFirestore.instance;
var _scriptureTextController = TextEditingController();
var _verseTextController = TextEditingController();

var _isScriptureError = false;
var _isVerseTextError = false;

class _DailyVerseState extends State<DailyVerse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Daily Verse"),
        ),
        drawer: const AppDrawer(),
        body: SingleChildScrollView(
            child: Container(
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
                        "Add Daily Verse",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: TextField(
                        controller: _scriptureTextController,
                        decoration: InputDecoration(
                          hintText: "(Eg: Genesis 1:1)",
                          label: const Text("Scripture"),
                          errorText: _isScriptureError
                              ? "Please enter the scripture"
                              : null,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(width: 1)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: TextField(
                        controller: _verseTextController,
                        decoration: InputDecoration(
                            // label: Text("Verse(s) Text"),
                            hintText: "Enter verse text...",
                            errorText: _isVerseTextError
                                ? "Please enter the bible verse"
                                : null,
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(width: 1))),
                        minLines: null,
                        maxLines: 6,
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
                          _uploadDailyVerse(
                              _scriptureTextController.text.toString().trim(),
                              _verseTextController.text.toString().trim());
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
                ))));
  }

  _uploadDailyVerse(String scripture, String verseText) {
    if (scripture.isEmpty || scripture == "") {
      setState(() {
        _isScriptureError = true;
      });
    } else {
      setState(() {
        _isScriptureError = false;
      });
    }

    if (verseText.isEmpty || verseText == "") {
      setState(() {
        _isVerseTextError = true;
      });
    } else {
      setState(() {
        _isVerseTextError = false;
      });
    }

    if (!_isScriptureError && !_isVerseTextError) {
      firestore.collection("daily verse").add({
        "scripture": scripture,
        "text": verseText,
        "datetime": DateTime.now().toString()
      }).then((value) {
        print("Uploaded");
        Fluttertoast.showToast(
            msg: "Daily Verse Uploaded Successfully",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG);
        _scriptureTextController.clear();
        _verseTextController.clear();
      }).catchError((error) => print("Error: $error"));
    }
  }
}
