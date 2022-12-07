// 견인 기록 확인 페이지

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:ui_repository/components/url.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var data = [];
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    this.fetchAccident();
  }

  Future fetchAccident() async {
    final response =
        await http.get(Uri.parse('${historyurl}records?user_id=${user?.uid}'));

    var list = [];
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      list = jsonDecode(responseBody);
    } else {
      throw Exception('Failed to load Accident');
    }

    setState(() {
      data = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context); //뒤로가기
                },
                color: Colors.black,
                icon: Icon(Icons.arrow_back)),
            title: Text('견인 기록 조회', style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
          ),
          body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: new ListView.builder(
                itemCount: data.isEmpty ? 1 : data.length,
                itemBuilder: (context, index) {
                  if (data.isNotEmpty) {
                    return Card(
                        margin: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text('${index+1}번째 사고 기록'),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                                '사고 내용: ${data[index]['accident']['message']}'),
                            Text(
                                '도로명: ${data[index]['accident']['road_name']}'),
                            Text(
                                '도로 번호: ${data[index]['accident']['road_num']}'),
                            Text('사고 시각: ${data[index]['date_time']}'),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ));
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 300),
                        Text('견인 기록 없음'),
                      ],
                    );
                  }
                }),
          )),
    );
  }
}
