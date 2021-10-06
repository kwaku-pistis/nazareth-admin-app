import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nazareth_upload_app/widgets/app_drawer.dart';

class DailyInspiration extends StatefulWidget {
  const DailyInspiration({Key? key}) : super(key: key);

  @override
  _DailyInspirationState createState() => _DailyInspirationState();
}

final FirebaseFirestore firestore = FirebaseFirestore.instance;
var _authorTextController = TextEditingController();
var _qouteTextController = TextEditingController();

var _isAuthorTextError = false;
var _isqouteTextError = false;

class _DailyInspirationState extends State<DailyInspiration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Daily Inspiration"),
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
                        "Add Daily Inspiration",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: TextField(
                        controller: _authorTextController,
                        decoration: InputDecoration(
                          hintText: "(Kenneth Hagin)",
                          label: const Text("Author"),
                          errorText: _isAuthorTextError
                              ? "Please enter the author"
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
                        controller: _qouteTextController,
                        decoration: InputDecoration(
                            hintText: "Enter quote...",
                            errorText: _isqouteTextError
                                ? "Please enter the quote"
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
                          _uploadDailyInspiration(
                              _authorTextController.text.toString().trim(),
                              _qouteTextController.text.toString().trim());
                        },
                        child: const Text(
                          "UPLOAD",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ))));
  }

  _uploadDailyInspiration(String author, String quote) {
    if (author.isEmpty || author == "") {
      setState(() {
        _isAuthorTextError = true;
      });
    } else {
      setState(() {
        _isAuthorTextError = false;
      });
    }

    if (quote.isEmpty || quote == "") {
      setState(() {
        _isqouteTextError = true;
      });
    } else {
      setState(() {
        _isqouteTextError = false;
      });
    }

    if (!_isAuthorTextError && !_isqouteTextError) {
      firestore
          .collection("daily inspiration")
          .add({"author": author, "quote": quote}).then((value) {
        print("Uploaded");
        Fluttertoast.showToast(
            msg: "Daily Verse Uploaded Successfully",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG);
        _authorTextController.clear();
        _qouteTextController.clear();
      }).catchError((error) => print("Error: $error"));
    }
  }
}
