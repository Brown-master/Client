import 'package:flutter/material.dart';

class InfoForm extends StatelessWidget {
  const InfoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(onPressed: () {}, child: Text('지도')),
        SizedBox(
          height: 10,
        ),
        Text('상세사고정보 출력단'),
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
