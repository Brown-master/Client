import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'url.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({Key? key}) : super(key: key);

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  var data = [];

  @override
  void initState() {
    super.initState();
    this.fetchAccident();
  }

  Future fetchAccident() async {
    final response = await http.get(accidenturl);

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
          child: ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (context, index) {
                return Card(
                    margin: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text('userId: ${data[index]['userId'].toString()}'),
                        Text('id: ${data[index]['id'].toString()}'),
                        Text('title: ${data[index]['title']}'),
                        Text(
                            'completed: ${data[index]['completed'].toString()}'),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pushNamed(context, '/info',
                                arguments: AccidentInfo(
                                    userId: data[index]['userId'],
                                    id: data[index]['id'],
                                    title: data[index]['title'],
                                    completed: data[index]['completed']));

                            final delete = await http.delete(Uri.parse(
                                '${accidenturl}/${data[index]['id']}'));
                            final get = await http.get(accidenturl);

                            var list = [];
                            if (get.statusCode == 200) {
                              String responseBody = utf8.decode(get.bodyBytes);
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
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () async {
                            final delete = await http.delete(Uri.parse(
                                '${accidenturl}/${data[index]['id']}'));
                            final get = await http.get(accidenturl);

                            var list = [];
                            if (get.statusCode == 200) {
                              String responseBody = utf8.decode(get.bodyBytes);
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
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ));
              }),
        ),
      ),
    );
  }
}

class AccidentInfo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  AccidentInfo(
      {required this.userId,
      required this.id,
      required this.title,
      required this.completed});
}
