import 'package:geolocator/geolocator.dart';

// 사용자 현재 위치 구하는 함수
Future<Position> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  return position;
}
