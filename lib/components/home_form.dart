// 사고 현황 확인 페이지

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'url.dart';
import 'package:geolocator/geolocator.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({Key? key}) : super(key: key);

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  var data = [];
  var lat;
  var lon;
  var duration;
  int check = 0; // 첫 polling인지 체크
  var response;
  String address = "";

  Stream getCurrentLocation() async* {
    // 첫 polling이면 Duration 1초, 아니면 5초
    if (check == 0) {
      duration = Duration(seconds: 1);
      check++;
    } else {
      duration = Duration(seconds: 5);
    }
    // duration만큼 delay된 polling 수행
    Future.delayed(duration, () async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      lat = position.latitude;
      lon = position.longitude;

      response = await http.get(Uri.parse(
          '${accidenturl}search?latitude=$lat&longitude=$lon')); // 사고 현황 get

      // statusCode 200이면 responseBody decode
      var list = [];
      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        list = jsonDecode(responseBody);
      } else {
        throw Exception('Failed to load Accident');
      }
      if (this.mounted) {
        setState(() {
          data = list;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            icon: Icon(Icons.arrow_back)),
        title: Text('사고 현황 조회', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        // StreamBuilder로 사고 현황을 계속해서 Polling
        child: StreamBuilder(
            stream: getCurrentLocation(),
            builder: (context, AsyncSnapshot snapshot) {
              return ListView.builder(
                  itemCount: data.isEmpty ? 1 : data.length,
                  itemBuilder: (context, index) {
                    if (data.isNotEmpty) {
                      // 사고 현황이 존재하면, Card 형태로 출력
                      return Card(
                          margin: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Text('사고 내용: ${data[index]['message']}'),
                              Text('도로명: ${data[index]['road_name']}'),
                              Text('도로 번호: ${data[index]['road_num']}'),
                              Text('도로 방향: ${data[index]['road_direction']}'),
                              Text('사고 시각: ${data[index]['date_time']}'),
                              SizedBox(
                                height: 20,
                              ),
                              // 수락 버튼 누르면, 서버에 파라미터를 전달해서 누군가가 사고를 수락했다고 서버에 전달
                              TextButton(
                                onPressed: () async {
                                  final get = await http.get(Uri.parse(
                                      '${accidenturl}accept?accident_id=${data[index]['accident_id']}'));
                                  var list = [];
                                  if (get.statusCode == 200) {
                                    if (get.body.toString() == "true") {
                                      Navigator.pushNamed(context, '/info',
                                          arguments: AccidentInfo(
                                            accident_id: data[index]
                                                ['accident_id'],
                                            message: data[index]['message'],
                                            road_name: data[index]['road_name'],
                                            road_num: data[index]['road_num'],
                                            road_direction: data[index]
                                                ['road_direction'],
                                            latitude: data[index]['latitude'],
                                            longitude: data[index]['longitude'],
                                            date_time: data[index]['date_time'],
                                          ));
                                    } else {
                                      return showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return WillPopScope(
                                              onWillPop: () async => false,
                                              child: AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                title: Column(
                                                  children: [
                                                    Text("이미 처리된 사고입니다."),
                                                  ],
                                                ),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                  } else {
                                    throw Exception('Failed to accept');
                                  }

                                  if (this.mounted) {
                                    setState(() {
                                      data = list;
                                      check = 0;
                                    });
                                  }
                                },
                                child: Text('수락'),
                                style: TextButton.styleFrom(
                                    minimumSize: Size(150, 50),
                                    padding: EdgeInsets.all(16.0),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ));
                    } else {
                      // 사고 현황이 없을 때 출력
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 300),
                          Text('사고 현황 없음'),
                        ],
                      );
                    }
                  });
            }),
      ),
    );
  }
}

// 사고 정보를 상세 사고 정보 페이지로 전달할 클래스
class AccidentInfo {
  final int accident_id;
  final String message;
  final String road_name;
  final int road_num;
  final String road_direction;
  final double latitude;
  final double longitude;
  final String date_time;

  AccidentInfo(
      {required this.accident_id,
      required this.message,
      required this.road_name,
      required this.road_num,
      required this.road_direction,
      required this.latitude,
      required this.longitude,
      required this.date_time});
}
