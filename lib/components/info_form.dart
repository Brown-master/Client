// 상세 사고 정보 페이지

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'url.dart';
import 'home_form.dart';

class InfoForm extends StatefulWidget {
  const InfoForm({Key? key}) : super(key: key);

  @override
  State<InfoForm> createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  final user = FirebaseAuth.instance.currentUser;
  late var user_latitude;
  late var user_longitude;
  var lat;
  var lon;
  String address = "";

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Stream<Position> getCurrentLocation() async* {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    yield position;
  }

  Future<String> getAddress() async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=AIzaSyCxeCqslVuJkR-gmT2oObsMdgrr6vfdYsI&language='
        'ko'
        ''));
    if (response.statusCode == 200) {
      setState(() {
        address = json.decode(response.body)['results'][0]['formatted_address'];
        address = address.substring(5);
      });
      return address;
    } else {
      throw Exception('Failed to load address');
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as AccidentInfo;
    lat = args.latitude;
    lon = args.longitude;
    getAddress();
    return Column(
      children: [
        StreamBuilder<Position>(
          // 사용자의 현재 위치를 계속해서 polling
          stream: getCurrentLocation(),
          builder: (context, AsyncSnapshot<Position?> snapshot) {
            if (snapshot.hasData) {
              user_latitude = snapshot.data?.latitude;
              user_longitude = snapshot.data?.longitude;
              // GoogleMap에 사고 지점의 위도, 경도를 전달
              return OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/map',
                        arguments: CurrentPositions(
                            latitude: args.latitude,
                            longtitude: args.longitude));
                  },
                  child: Text('지도'));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
        SizedBox(
          height: 10,
        ),
        Text('사고 정보: ${args.message}'),
        Text('사고지 주소 : ${address}'),
        SizedBox(
          height: 10,
        ),
        // 완료 버튼을 누르면, 완료 기준을 충족했는지 검사
        TextButton(
            onPressed: () async {
              final response = await http.get(Uri.parse(
                  '${historyurl}clear?user_id=${user?.uid}&accident_id=${args.accident_id}&accident_latitude=${args.latitude}&accident_longitude=${args.longitude}&user_latitude=${user_latitude}&user_longitude=${user_longitude}'));
              if (response.statusCode == 200) {
                if (response.body.toString() == "true") {
                  Navigator.pop(context);
                } else {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return WillPopScope(
                          onWillPop: () async => false,
                          child: AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            title: Column(
                              children: [
                                Text(
                                  "사고 현장에 도착하지 않았습니다!",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
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
              } else {
                throw Exception('Failed to finish');
              }
            },
            child: Text("완료")),
        SizedBox(
          height: 10,
        ),
        // 완료하지 않고 모종의 이유로 닫기 버튼을 누르면, cancel 상태를 서버에 전달
        TextButton(
            onPressed: () async {
              final response = await http.get(Uri.parse(
                  '${accidenturl}cancel?accident_id=${args.accident_id}'));
              Navigator.pop(context);
            },
            child: Text("닫기"))
      ],
    );
  }
}

// 위도, 경도를 map에 전달할 클래스
class CurrentPositions {
  final double latitude;
  final double longtitude;

  CurrentPositions({required this.latitude, required this.longtitude});
}
