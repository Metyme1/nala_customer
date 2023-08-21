
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nala_c/screens/pickup_drop.dart';
class MapPage extends StatefulWidget {
  final String phoneNumber;

  const MapPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState(phoneNumber: phoneNumber);
}

class _MapPageState extends State<MapPage> {
  String _selectedOption = 'English';
  String _selectedLanguage = 'en';
  final String phoneNumber;

  _MapPageState({required this.phoneNumber});

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 late LatLng _center ;
  BitmapDescriptor? _markerIcon; // Nullable BitmapDescriptor

  Future<Position> getlo() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showSnackBar('Location services disabled');
      return Future.error('Location services disabled');
    }

    final LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final LocationPermission permissionRequestResult = await Geolocator.requestPermission();
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    super.initState();
    getlo();
    _loadMarkerIcon();
  }

  Future<void> _loadMarkerIcon() async {
    final  markerIcon = BitmapDescriptor.defaultMarker;

    setState(() {
      _markerIcon = markerIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          if (_center != null)
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 15.0,
              ),
              mapType: MapType.normal,
              markers: {
                if (_markerIcon != null) // Check if the marker icon is loaded
                  Marker(
                    markerId: MarkerId('current_location'),
                    position: _center,
                    icon: _markerIcon!,
                    anchor: Offset(0.5, 0.5),
                  ),
              },
              myLocationEnabled: true, // Enable the "My Location" button
              myLocationButtonEnabled: false, // Hide the default "My Location" button
              onMapCreated: (GoogleMapController controller) {
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
              ],
            ),
          ),
          Positioned(
            top: 46,
            right: 20,
            child: DropdownButton<String>(
              value: _selectedLanguage,
              items: <String>[
                'English',
                'Amharic',

              ].map((String value) {
                return DropdownMenuItem(
                  value: value.substring(0, 2).toLowerCase(),
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
                if (_selectedLanguage == 'am') {
                  EasyLocalization.of(context)?.setLocale(Locale('am', 'ET'));
                }

                else{
                EasyLocalization.of(context)?.setLocale(Locale('en', 'US'));
                }
              },
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 5.0,
            right: 5.0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(phoneNumber: widget.phoneNumber)),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.blueAccent],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.car_rental,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'order'.tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),drawer: Container(
      width: 250.0, // Set the desired width for the drawer
      child: Drawer(
        backgroundColor: Colors.blueAccent,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.blueAccent,
                        size: 40.0,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        widget.phoneNumber,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Nala ride'.tr(),
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.wallet,
                color: Colors.white,
                size: 24.0,
              ),
              title: Text(
                'Wallet'.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                ),
              ),
              onTap: () {
                // Handle item 1 tap
              },
            ),
            ListTile(
              leading: Icon(
                Icons.notification_important,
                color: Colors.white,
                size: 24.0,
              ),
              title: Text(
                'Notifications'.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                ),
              ),
              onTap: () {
                // Handle item 2 tap
              },
            ),
            ListTile(
              leading: Icon(
                Icons.history,
                color: Colors.white,
                size: 24.0,
              ),
              title: Text(
                'History'.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                ),
              ),
              onTap: () {
                // Handle item 3 tap
              },
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(
                color: Colors.white,
                thickness: 1.0,
              ),
            ),
            SizedBox(height: 20.0),
            ListTile(
              leading: Icon(
                Icons.schedule,
                color: Colors.white,
                size: 24.0,
              ),
              title: Text(
                'Preorder'.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                ),
              ),
              onTap: () {
                // Handle item 4 tap
              },
            ),
            ListTile(
              leading: Icon(
                Icons.car_rental,
                color: Colors.white,
                size: 24.0,
              ),
              title: Text(
                'Free Nala Mile'.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                ),
              ),
              onTap: () {
                // Handle item 5 tap
              },
            ),
            ListTile(
              leading: Icon(
                Icons.feedback,
                color: Colors.white,
                size: 24.0,
              ),
              title: Text(
                'App Feedback'.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                ),
              ),
              onTap: () {
                // Handle item 6 tap
              },
            ),
          ],
        ),
      ),
    ),

    );
  }
}
