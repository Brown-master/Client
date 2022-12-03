import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ui_repository/pages/home_page.dart';

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("firebase load fail"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return HomePage();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
