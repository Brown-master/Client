// 메인 페이지 Scaffold

import 'package:flutter/material.dart';
import 'package:ui_repository/components/logo_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.data != null) {
            return WillPopScope(
                child: Scaffold(
                    appBar: AppBar(
                      iconTheme: IconThemeData(
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                    ),
                    // 사이드 메뉴
                    drawer: Drawer(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.home, color: Colors.black),
                            title: Text('내 정보'),
                            onTap: () {
                              _showUserInfo(context, snapshot);
                            },
                            trailing: Icon(Icons.arrow_forward),
                          ),
                          ListTile(
                            leading: Icon(Icons.history, color: Colors.black),
                            title: Text('견인 기록'),
                            onTap: () {
                              Navigator.pushNamed(context, '/history');
                            },
                            trailing: Icon(Icons.arrow_forward),
                          ),
                          ListTile(
                            leading: Icon(Icons.logout, color: Colors.black),
                            title: Text('로그아웃'),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return WillPopScope(
                                      onWillPop: () async => false,
                                      child: AlertDialog(
                                        // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0)),
                                        //Dialog Main Title
                                        title: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("로그아웃 하시겠습니까?"),
                                          ],
                                        ),
                                        //
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                FirebaseAuth.instance.signOut();
                                                Navigator.pop(context);
                                              },
                                              child: Text("예"),
                                            ),
                                            SizedBox(height: 10,),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("아니오"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                    body: ListView(
                      children: [
                        Logo("사고 정보 확인"),
                        SizedBox(
                          height: 50,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/accident');
                            },
                            child: Text("사고 정보 조회"))
                      ],
                    )),
                onWillPop: () async => false);
          } else
            return LoginPage();
        });
  }

  // 내 정보를 팝업으로 출력할 함수
  Future<dynamic> _showUserInfo(
      BuildContext context, AsyncSnapshot<User?> snapshot) {
    return showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              //Dialog Main Title
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("이름: ${snapshot.data!.displayName}"),
                  Text('이메일: ${snapshot.data!.email}', style: TextStyle(fontSize: 15),),
                ],
              ),
              //
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("닫기"),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
