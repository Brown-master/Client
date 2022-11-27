import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // global key
  final _formkey = GlobalKey<FormState>();
  bool obscure_password = true;
  bool obscure_password_check = true;
  String password = "";

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
                obscureText: obscure_password,

                // 힌트 문자나 여러가지 데코레이션 기능 추가
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscure_password
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          obscure_password = !obscure_password;
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
          ), // 텍스트 박스와 비밀번호 확인 사이의 간격

          // password check
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("비밀번호 확인"),
              SizedBox(
                height: 10,
              ), // 글자와 텍스트 박스 사이의 간격
              TextFormField(
                // password 폼 공백이면 message 출력
                validator: (value) =>
                    value!.isEmpty ? "비밀번호가 일치하지 않습니다." : null,

                // text가 Password일 경우 마킹 처리 true
                obscureText: obscure_password_check,

                // 힌트 문자나 여러가지 데코레이션 기능 추가
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscure_password_check
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          obscure_password_check = !obscure_password_check;
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
          ), // 텍스트 박스와 회원가입 버튼 사이의 간격

          // Car Number
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("차량번호"),
              SizedBox(
                height: 10,
              ), // 글자와 텍스트 박스 사이의 간격
              TextFormField(
                // password 폼 공백이면 message 출력
                validator: (value) => value!.isEmpty ? "차량번호를 입력해주세요." : null,

                // 힌트 문자나 여러가지 데코레이션 기능 추가
                decoration: InputDecoration(
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
          ), // 텍스트 박스와 회원가입 버튼 사이의 간격

          // Phone Number
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("전화번호"),
              SizedBox(
                height: 10,
              ), // 글자와 텍스트 박스 사이의 간격
              TextFormField(
                // password 폼 공백이면 message 출력
                validator: (value) => value!.isEmpty ? "전화번호를 입력해주세요." : null,

                // 힌트 문자나 여러가지 데코레이션 기능 추가
                decoration: InputDecoration(
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
          ), // 텍스트 박스와 회원가입 버튼 사이의 간격

          TextButton(
            onPressed: () {
              /// 네비게이터로 화면 이동, routes의 이름을 적어 이동한다
              Navigator.pushNamed(context, "/login");
            },
            child: Text("회원가입"),
          ),

          SizedBox(
            height: 20,
          ),

          TextButton(
            onPressed: () {
              /// 네비게이터로 화면 이동, routes의 이름을 적어 이동한다
              Navigator.pop(context);
            },
            child: Text("취소"),
          ),

          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
