import 'package:flutter/material.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({Key? key}) : super(key: key);

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  late var isworking;
  late var workingmessage;

  @override
  void initState() {
    isworking = false;
    workingmessage = "눌러서 출근";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      //Dialog Main Title
                      title: Column(
                        children: <Widget>[
                          new Text("사고정보 확인"),
                          new Text('사고정보 출력단')
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
                              Navigator.pushNamed(context, "/info");
                            },
                            child: Text("수락"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("거절"),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Text("팝업 테스트용 버튼(삭제예정)")),
        SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: toggleSelect,
          child: Text("$workingmessage"),
        ),
      ],
    );
  }

  void toggleSelect() {
    if (!isworking) {
      isworking = true;
      workingmessage = "눌러서 퇴근";
    } else {
      isworking = false;
      workingmessage = "눌러서 출근";
    }
    setState(() {

    });
  }
}