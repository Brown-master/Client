import 'package:flutter/material.dart';
import 'package:ui_repository/pages/home_page.dart';
import 'package:ui_repository/pages/login_page.dart';
import 'package:ui_repository/pages/register_page.dart';
import 'package:ui_repository/pages/accident_info_page.dart';
import 'firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      // 테마설정
      theme: ThemeData(
        /// 전체 TextButton 테마를 지정하면 모든 TextButton에 테마가 적용된다.
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                backgroundColor: Colors.yellow,
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(400, 60))),
      ),

      /// 화면이동을 위해 route를 사용
      initialRoute: "/login", // 초기 경로 설정
      routes: {
        // 경로 목록
        "/login": (context) => LoginPage(),
        "/home": (context) => HomePage(),
        "/register": (context) => RegisterPage(),
        "/info": (context) => InfoPage()
      },
    );
  }
}
