// 초기 로그인 정보가 없을 때 로그인 기능 제공 페이지

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
            ),
            Logo("로그인"),
            SizedBox(
              height: 50,
            ),
            makeSignInButton("assets/images/google.PNG"),
          ],
        ),
      )),
    );
  }
}

// 위치 권한 얻기
Future<bool> location_permission() async {
  Map<Permission, PermissionStatus> status =
      await [Permission.location].request(); // [] 권한배열에 권한을 작성

  if (await Permission.location.isGranted) {
    return Future.value(true);
  } else {
    return Future.value(false);
  }
}

// 로그인 버튼 생성
TextButton makeSignInButton(String imageaddress) {
  return TextButton(
    onPressed: () {
      if (imageaddress == "assets/images/google.PNG") {
        signInWithGoogle();
      }
    },
    child: Image.asset(
      imageaddress,
      height: 50,
      width: 50,
    ),
    style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap),
  );
}

// 구글 로그인 함수
Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;
  final OAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
