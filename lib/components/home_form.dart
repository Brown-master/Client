import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ui_repository/components/reverse_geocoding.dart';
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
  var address;
  StreamController<dynamic> _events = new StreamController<dynamic>();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    address = getAddress();
  }

  Stream<void> getCurrentLocation() async* {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //lat = position.latitude;
    //lon = position.longitude;
    lat = 37.5323;
    lon = 127.1938;

    fetchAccident(lat: lat, lon: lon);
  }

  Stream<http.Response> fetchAccident({required lat, required lon}) async* {
    //final response = await http
    //    .get(Uri.parse('${accidenturl}latitude=$lat&longitude=$lon'));

    final response = await http.get(historyurl);

    var list = [];
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      list = jsonDecode(responseBody);
    } else {
      throw Exception('Failed to load Accident');
    }
    setState(() {
      data = list;
      _events.add(data);
    });

    yield* Stream.periodic(Duration(seconds: 5), (_) {
      return http.get(historyurl);
    }).asyncMap((event) async => await event);
  }

  Stream<Accident> getAddress() async* {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=AIzaSyCxeCqslVuJkR-gmT2oObsMdgrr6vfdYsI&language='
        'ko'
        ''));
    if (response.statusCode == 200) {
      yield Accident.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load address');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context); //뒤로가기
            },
            color: Colors.black,
            icon: Icon(Icons.arrow_back)),
        title: Text('사고 현황 조회', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Scrollbar(
          thickness: 5.0, // 스크롤 너비
          radius: Radius.circular(8.0), // 스크롤 라운딩
          child: StreamBuilder(
              stream: fetchAccident(lat: lat, lon: lon),
              builder: (context, AsyncSnapshot snapshot) {
                return ListView.builder(
                    itemCount: data.isEmpty ? 1 : data.length,
                    itemBuilder: (context, index) {
                      if (data.isNotEmpty) {
                        return Card(
                            margin: EdgeInsets.all(10),
                            color: Colors.white,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                //Text('사고 내용: ${data[index]['message']}'),
                                //Text('도로명: ${data[index]['road_name']}'),
                                //Text('도로번호: ${data[index]['road_direction']}'),
                                //Text(
                                //    '주소명: ${snapshot.data?.results?[0].formattedAddress}'),
                                //Text('사고 시각: ${data[index]['date_time']}'),
                                Text('userId: ${data[index]['userId'].toString()}'),
                                Text('id: ${data[index]['id'].toString()}'),
                                Text('title: ${data[index]['title']}'),
                                Text('completed: ${data[index]['completed'].toString()}'),
                                SizedBox(
                                  height: 20,
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pushNamed(context, '/info',
                                        //arguments: AccidentInfo(
                                        //  accident_id: data[index]
                                        //      ['accident_id'],
                                        //  message: data[index]['message'],
                                        //  road_name: data[index]['road_name'],
                                        //  road_num: data[index]['road_num'],
                                        //  road_direction: data[index]
                                        //      ['road_direction'],
                                        //  latitude: data[index]['latitude'],
                                        //  longitude: data[index]['longitude'],
                                        //  date_time: data[index]['date_time'],
                                      arguments: Test(
                                        userId: data[index]['userId'],
                                        id: data[index]['id'],
                                        title: data[index]['title'],
                                        completed: data[index]['completed']
                                        ));

                                    //final delete = await http.delete(Uri.parse(
                                    //    '${accidenturl}/${data[index]['accident_id']}'));
                                    //final get = await http.get(Uri.parse(
                                    //    '${accidenturl}${lat}&${lon}'));

                                    final delete = await http.delete(Uri.parse('http://localhost:8000/posts/${data[index]['id']}'));
                                    final get = await http.get(Uri.parse('http://localhost:8000/posts'));

                                    var list = [];
                                    if (get.statusCode == 200) {
                                      String responseBody =
                                          utf8.decode(get.bodyBytes);
                                      list = jsonDecode(responseBody);
                                    } else {
                                      throw Exception('Failed to delete');
                                    }

                                    setState(() {
                                      data = list;
                                    });
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
                                TextButton(
                                  onPressed: () async {
                                    //final delete = await http.delete(Uri.parse(
                                    //    '${accidenturl}/${data[index]['accident_id']}'));
                                    //final get = await http.get(Uri.parse(
                                    //    '${accidenturl}${lat}&${lon}'));

                                    final delete = await http.delete(Uri.parse('http://localhost:8000/posts/${data[index]['id']}'));
                                    final get = await http.get(Uri.parse('http://localhost:8000/posts'));

                                    var list = [];
                                    if (get.statusCode == 200) {
                                      String responseBody =
                                          utf8.decode(get.bodyBytes);
                                      list = jsonDecode(responseBody);
                                    } else {
                                      throw Exception('Failed to delete');
                                    }

                                    setState(() {
                                      data = list;
                                    });
                                  },
                                  child: Text('거절'),
                                  style: TextButton.styleFrom(
                                      minimumSize: Size(150, 50),
                                      padding: EdgeInsets.all(16.0),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ));
                      } else {
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
      ),
    );
  }
}

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

class Test {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Test({required this.userId, required this.id, required this.title, required this.completed});
}
