import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ui_repository/components/info_form.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CurrentPositions;
    return Scaffold(
        appBar: AppBar(
          title: const Text('사고 위치 확인', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.yellow,
          foregroundColor: Colors.black,
        ),
        body: GoogleMap(
          onMapCreated: (controller) {
            setState(() {
              _controller = controller;
            });
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(args.latitude, args.longtitude),
            zoom: 18.0,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        ));
  }
}
