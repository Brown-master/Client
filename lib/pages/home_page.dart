import 'package:flutter/material.dart';
import 'package:ui_repository/components/logo_form.dart';
import 'package:ui_repository/components/home_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            UserAccountsDrawerHeader(
                accountName:
                    Text("브라운 석사", style: TextStyle(color: Colors.black)),
                accountEmail: Text("차량번호 or 휴대폰번호",
                    style: TextStyle(color: Colors.black)),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(20),
                )),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.black
              ),
              title: Text('내 정보'),
              onTap: (){},
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              leading: Icon(
                  Icons.history,
                  color: Colors.black
              ),
              title: Text('견인 기록'),
              onTap: (){},
              trailing: Icon(Icons.arrow_forward),
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
            HomeForm(),
          ],
        ),
      ),
    );
  }
}
// TODO:출근 페이지를 추가하고 출근 누르면 콜 대기중으로 이동하도록 -> 페이지를 하나로 하고 버튼 토글 -> 출근일 때 다이얼로그 뜰 수 있게
// TODO:drawer 메뉴별로 페이지 추가하기
// TODO:drawer에 이름 번호 빼고 사진을 넣을까?