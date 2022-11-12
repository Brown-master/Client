import 'package:flutter/material.dart';
import 'package:ui_repository/components/register_form.dart';
import 'package:ui_repository/components/logo_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
          Logo("회원가입"),
          SizedBox(
            height: 50,
          ), // 로그인 글자와 ID 글자 사이의 간격
          RegisterForm(), // ID, Password 입력 창
        ],
      ),
    ));
  }
}
