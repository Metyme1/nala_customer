import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;

class PositionProvider with ChangeNotifier {
  late maps.LatLng _center;

  maps.LatLng get center => _center;

  Future<void> updateCenter() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services disabled');
    }

    final LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final LocationPermission permissionRequestResult =
      await Geolocator.requestPermission();
      if (permissionRequestResult == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _center = maps.LatLng(position.latitude, position.longitude);
    notifyListeners();
  }
}