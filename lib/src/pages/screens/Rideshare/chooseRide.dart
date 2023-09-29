

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as GoogleMaps;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart' as latLng2;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;



class Shared extends StatefulWidget {
  // final String pickupLocation;
  // final String dropOffLocation;
  // final double pickupLocationLatitude;
  // final double pickupLocationLongitude;
  // final double dropOffLocationLatitude;
  // final double dropOffLocationLongitude;
  // final DateTime selectedDateTime;
  final String fullName;
  final String phoneNumber;
  final String rideType;
  final String selectedCarOption;

  Shared({
    // required this.pickupLocation,
    // required this.dropOffLocation,
    // required this.pickupLocationLatitude,
    // required this.pickupLocationLongitude,
    // required this.dropOffLocationLatitude,
    // required this.dropOffLocationLongitude,
    //required this.selectedDateTime,
    required this.phoneNumber,
    required this.rideType,
    required this.fullName,
    required this.selectedCarOption,

  });

  @override
  _SharedState createState() => _SharedState();
}

class _SharedState extends State<Shared> {
  Set<GoogleMaps.Polyline> polylines = {};
  String selectedRideOption = '';
  bool isMinivanSelected = false;
  double totalDistance = 0.0;
  List<String> directions = [];
  late GoogleMapController mapController;
  Position? currentLocation;

  @override

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late LatLng _center;
  BitmapDescriptor? _markerIcon; // Nullable BitmapDescriptor

  Future<Position> getlo() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showSnackBar('Location services disabled');
      return Future.error('Location services disabled');
    }

    final LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final LocationPermission permissionRequestResult =
      await Geolocator.requestPermission();
      if (permissionRequestResult == LocationPermission.denied) {
        _showSnackBar('Location permission denied');
        return Future.error('Location permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _showSnackBar('Location permissions are permanently denied');
      return Future.error('Location permissions are permanently denied');
    }

    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _center = LatLng(position.latitude, position.longitude);
    });
    return position;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)));
  }
  void initState() {
    super.initState();
    getlo();
    _loadMarkerIcon();
  }
  Future<void> _loadMarkerIcon() async {
    final markerIcon = BitmapDescriptor.defaultMarker;

    setState(() {
      _markerIcon = markerIcon;
    });
  }



  @override

  Widget build(BuildContext context) {
    LatLng targetLatLng = LatLng(
      currentLocation?.latitude ?? 37.422,
      currentLocation?.longitude ?? -122.084,
    );

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: _buildMap(),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  'Shared ride',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildMap() {
    return Stack(
      children: [
        if (_center != null)
          maps.GoogleMap(
            initialCameraPosition: maps.CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            mapType: maps.MapType.normal,
            markers: {
              if (_markerIcon != null) // Check if the marker icon is loaded
                maps.Marker(
                  markerId: maps.MarkerId('current_location'),
                  position: _center,
                  icon: _markerIcon!,
                  anchor: Offset(0.5, 0.5),
                ),
            },
            myLocationEnabled: true, // Enable the "My Location" button
            myLocationButtonEnabled: false, // Hide the default "My Location" button
            zoomControlsEnabled: false, // Hide the zoom controls
            compassEnabled: true, // Show the compass
            onMapCreated: (maps.GoogleMapController controller) {
              // Optional: You can customize the map controller settings here
            },
          ),
      ],
    );
  }
}