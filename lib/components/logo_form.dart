import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;

  //const Logo({Key? key}) : super(key: key);
  const Logo(this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/logo.PNG",
          height: 200,
          width: 200,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
