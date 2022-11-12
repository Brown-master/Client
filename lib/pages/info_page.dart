import 'package:flutter/material.dart';
import 'package:ui_repository/components/info_form.dart';
import 'package:ui_repository/components/logo_form.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          Logo("상세 사고 정보"),
          SizedBox(
            height: 10,
          ),
          InfoForm(), // ID, Password 입력 창
        ],
      ),
    ));
  }
}
