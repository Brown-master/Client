시연동영상 링크 https://youtu.be/TbmlQH5Tuvc
# 2022-Open Source Project

# 견인차량들 사이의 간의 경쟁에서 나오는 불법행위를 줄이기 위한 어플리케이션

##### Project name : 견人
#### Team name : Brown Master
#### Project execution period : 2022.09.29~2022.12.08
#### GIT HUB URL :  [GIT HUB](https://github.com/Brown-master/Client)
-----------------------
## Decritpion
사고 차량을 견인 하는 견인 차량들이 서로 먼저 가기 위해서 불법행위와 2차사고가 발생하는 경우가 많다.   
하지만 만약 견인 차량들 간의 우선 순위가 있었더라면 2차사고와 불법행위를 예방할 수 있지 않않을까 생각된다. 이러한 이유들을 바탕으로 프로젝트를 개발하게 되었다. 견인 차량(사용자) 입장에서 계획했던 프로젝트이므로 견인 차량들을 위해 사고 차량에 대한 우선 순위를 주고 수락과 거절을 통해 사고 차량에 대한 견인 여부를 결정하는 기능을 구현했다.
먼저 도로에서 발생하는 사고를 실시간으로 분석하고 사고메시지로 알려준다.
사용자들에게 수락 거절 버튼을 이용하여 우선 순위를 제공한다. 
수락을 할 시에는 사고 위치 정보와 현재 위치정보를 알려주며   
거절 시에는 거절한 사고를 제외하고 다른 사고들을 보여준다.
또한 사용자가 견인기록을 조회하고 싶을 시에는 조회할 수 있다.  
이러한 기능들을 사용해서 견인 차량들 사이의 우선 순위, 사고정보와 견인 기록 조회를 할 수 있고 견인 차량 사이의 불법행위와 2차사고를 관리할 수 있다.

## UI흐름도
![kk](https://user-images.githubusercontent.com/101470043/206215208-4544dac9-16f8-4f3f-91f9-cde3228098e8.png)

 ## Language
>Dart version 2.18.0
## Open Source, Open API
>Flutter version 3.3.0
>Google login
> geocoding 2.0.5

## Dependencies

>'flutter_svg: ^1.0.0'
>'firebase_core:'
>'cloud_firestore:'
>'geolocator:'
>'google_maps_flutter:'
>'google_maps_flutter_web:'
>'permission_handler:'
>'firebase_auth:'
>'http:'
>'google_sign_in:'

## Files
`home_form.dart`  사고 현황 확인 페이지

`info_form.dart`  상세 사고 정보 페이지

`logo_form.dart`  로고 및 페이지 타이틀 생성 Form

`url.dart`  서버와 통신할 Url

`accident_info_page.dart`  상세 사고 정보 페이지 Scaffold

`home_page.dart`  메인 페이지 Scaffold

`login_page.dart`  로그인 정보가 없을 때 로그인 기능 제공 페이지

`map_page.dart`  구글 지도 출력 페이지

`tow_history-page.dart`  견인 기록 확인 페이지

`firebase_options.dart`  파이어 베이스 옵션 파일

`init.dart`  로그인 상태 체크 페이지

`main.dart`  초기 화면을 init.dart로 시작

