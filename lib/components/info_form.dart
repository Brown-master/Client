import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class InfoForm extends StatefulWidget {
  const InfoForm({Key? key}) : super(key: key);

  @override
  State<InfoForm> createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  late Future<Position> position;

  @override
  void initState() {
    super.initState();
    position = getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(onPressed: () {}, child: Text('지도')),
        SizedBox(
          height: 10,
        ),
        FutureBuilder<Position> (
          future: position,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return Text('상세사고정보 출력단');
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
        SizedBox(
          height: 10,
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("닫기"))
      ],
    );
  }
}

// 사용자 현재 위치 구하는 함수
Future<Position> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  return position;
}
