import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nala_c/src/config/platte.dart';


import '../../widget/drawer.dart';
import '../../widget/orderButton.dart';

class MapPage extends StatefulWidget {
  final String phoneNumber;
  final String FullName;
  //
  // final bool isSharedRide;
  const MapPage({Key? key, required this.phoneNumber,required this.FullName}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState(phoneNumber: phoneNumber, FullName: FullName,);
}

class _MapPageState extends State<MapPage> {
  String _selectedOption = 'English';
  String _selectedLanguage = 'en';
  final String phoneNumber;
  final String FullName;
  bool isShareRideSelected = false;
  String _selectedRideType = ''; // Add this line

  bool isNormalRideSelected = false;


  _MapPageState({required this.phoneNumber, required this.FullName});

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

  @override
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

  String _rideTypeValue = "Shared Ride";


  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Scaffold(
          key: _scaffoldKey,
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: _buildMap(),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    //  SizedBox(height: 16.0),
                    _buildRideRequestCard(),
                    //  SizedBox(height: 16.0),
                    buildOrderButton(context, phoneNumber, _rideTypeValue,FullName)
                    //  SizedBox(height: 16.0),
                  ],
                ),
              ),
            ],
          ),

          drawer: AppDrawer()
        )
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
        Positioned(
          top: 46.0,
          left: 16.0,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer(); // Open the drawer when the menu button is pressed
                  },
                ),
              ),
              SizedBox(height: 16.0),


            ],
          ),
        ),
        Positioned(
          top: 46.0,
          right: 16.0,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: Icon(Icons.person),
                  onPressed: ()  {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SettingsPage(
                    //       phoneNumber: widget.phoneNumber,
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
              SizedBox(height: 16.0),


            ],
          ),
        ),
      ],
    );
  }
  Widget _buildRideRequestCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Ride Request',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              CupertinoSlidingSegmentedControl(
                children: {
                  'shared': Text('Share Ride'),
                  'normal': Text('Normal Ride'),
                },
                groupValue: _rideTypeValue == 'shared' ? 'shared' : 'normal',
                onValueChanged: (value) {
                  setState(() {
                    _rideTypeValue = value.toString();
                  });
                  // Handle ride type selection
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}