import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // global key
  final _formkey = GlobalKey<FormState>();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      // global key를 form에 지정하여 해당 key로 form의 상태를 관리
      key: _formkey,
      child: Column(
        children: [
          // Email
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("이메일"),
              SizedBox(
                height: 10,
              ), // 글자와 텍스트 박스 사이의 간격
              TextFormField(
                // ID, password 폼 공백이면 message 출력
                validator: (value) =>
                    value!.isEmpty ? "올바른 이메일을 입력해주세요." : null,

                // 힌트 문자나 여러가지 데코레이션 기능 추가
                decoration: InputDecoration(
                    hintText: "예 : example@email.com",
                    // 힌트문자
                    enabledBorder: OutlineInputBorder(
                      // 기본 모양
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // 포커스 되었을 경우 모양
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorBorder: OutlineInputBorder(
                        // 에러 발생 시 모양
                        borderRadius: BorderRadius.circular(20)),
                    focusedErrorBorder: OutlineInputBorder(
                        // 에러 발생 후 포커스 되었을 경우 모양
                        borderRadius: BorderRadius.circular(20))),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ), // 텍스트 박스와 다음 글자 사이의 간격

          // Password
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("비밀번호"),
              SizedBox(
                height: 10,
              ), // 글자와 텍스트 박스 사이의 간격
              TextFormField(
                // password 폼 공백이면 message 출력
                validator: (value) =>
                    value!.isEmpty ? "올바른 비밀번호를 입력해주세요." : null,

                // text가 Password일 경우 마킹 처리 true
                obscureText: obscure,

                // 힌트 문자나 여러가지 데코레이션 기능 추가
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscure ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      // 기본 모양
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // 포커스 되었을 경우 모양
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorBorder: OutlineInputBorder(
                        // 에러 발생 시 모양
                        borderRadius: BorderRadius.circular(20)),
                    focusedErrorBorder: OutlineInputBorder(
                        // 에러 발생 후 포커스 되었을 경우 모양
                        borderRadius: BorderRadius.circular(20))),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ), // 텍스트 박스와 로그인 버튼 사이의 간격

          TextButton(
            onPressed: () {
              /// 네비게이터로 화면 이동, routes의 이름을 적어 이동한다
              Navigator.pushNamed(context, "/register");
            },
            child: Text("회원가입"),
          ),

          SizedBox(
            height: 20,
          ),

          // 로그인 버튼
          TextButton(
            onPressed: () {
              /// 유효성 검사
              if (_formkey.currentState!.validate()) {
                /// 네비게이터로 화면 이동, routes의 이름을 적어 이동한다
                Navigator.pushNamed(context, "/home");
              }
            },
            child: Text("로그인"),
          )
        ],
      ),
    );
  }
}
