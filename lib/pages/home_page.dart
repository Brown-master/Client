import 'package:flutter/material.dart';
import 'package:ui_repository/components/logo_form.dart';
import 'package:ui_repository/components/home_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
//            UserAccountsDrawerHeader(
//                accountName:
//                    Text("브라운 석사", style: TextStyle(color: Colors.black)),
//                accountEmail: Text("차량번호 or 휴대폰번호",
//                    style: TextStyle(color: Colors.black)),
//                decoration: BoxDecoration(
//                  color: Colors.yellow,
//                  borderRadius: BorderRadius.circular(20),
//                )),
              ListTile(
                leading: Icon(Icons.home, color: Colors.black),
                title: Text('내 정보'),
                onTap: () {
                  _showUserInfo(context);
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
                  Navigator.pushNamed(context, '/login');
                },
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              SizedBox(
                height: 50,
              ),
              Logo("콜 대기중..."),
              SizedBox(
                height: 50,
              ),
              HomeForm()
            ],
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }

  Future<dynamic> _showUserInfo(BuildContext context) {
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
                children: <Widget>[new Text("내 정보 출력단")],
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
