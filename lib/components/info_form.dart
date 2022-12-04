import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'home_form.dart';

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

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as AccidentInfo;
    return Column(
      children: [
        FutureBuilder<Position>(
          future: position,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
        Text('accidentID: ${args.accident_id}'),
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

class CurrentPositions {
  final double latitude;
  final double longtitude;

  CurrentPositions({required this.latitude, required this.longtitude});
}
