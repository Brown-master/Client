import 'package:flutter/material.dart';
import 'package:ui_repository/components/register_form.dart';
import 'package:ui_repository/components/logo_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Logo("회원가입"),
            SizedBox(
              height: 50,
            ),
            RegisterForm()
          ],
        ),
      )),
    );
  }
}
