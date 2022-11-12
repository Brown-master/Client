import 'package:flutter/material.dart';
import 'package:ui_repository/components/login_form.dart';
import 'package:ui_repository/components/logo_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          SizedBox(
            height: 50,
          ), // 상단과 로고 시작 사이의 간격
          Logo("로그인"),
          SizedBox(
            height: 50,
          ), // 로그인 글자와 ID 글자 사이의 간격
          LoginForm(), // ID, Password 입력 창
        ],
      ),
    ));
  }
}
