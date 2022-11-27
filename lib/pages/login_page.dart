import 'package:flutter/material.dart';
import 'package:ui_repository/components/login_form.dart';
import 'package:ui_repository/components/logo_form.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Future<bool> location;

  @override
  void initState() {
    super.initState();
    location = location_permission();
  }

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
            ), // 상단과 로고 시작 사이의 간격
            Logo("로그인"),
            SizedBox(
              height: 50,
            ), // 로그인 글자와 ID 글자 사이의 간격
            LoginForm(), // ID, Password 입력 창
          ],
        ),
      )),
    );
  }
}

Future<bool> location_permission() async {
  Map<Permission, PermissionStatus> status =
      await [Permission.location].request(); // [] 권한배열에 권한을 작성

  if (await Permission.location.isGranted) {
    return Future.value(true);
  } else {
    return Future.value(false);
  }
}
