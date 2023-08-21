import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as GoogleMaps;

import 'confirm.dart';

class ChoosingRidePage extends StatefulWidget {
  final String pickupLocation;
  final String dropOffLocation;
  final double pickupLocationLatitude;
  final double pickupLocationLongitude;
  final double dropOffLocationLatitude;
  final double dropOffLocationLongitude;
  final String phoneNumber;
  final DateTime selectedDateTime;

  ChoosingRidePage({
    required this.pickupLocation,
    required this.dropOffLocation,
    required this.pickupLocationLatitude,
    required this.pickupLocationLongitude,
    required this.dropOffLocationLatitude,
    required this.dropOffLocationLongitude,
    required this.phoneNumber,
    required this.selectedDateTime,
  });

  @override
  _ChoosingRidePageState createState() => _ChoosingRidePageState();
}
class _ChoosingRidePageState extends State<ChoosingRidePage> {
  Set<GoogleMaps.Polyline> polylines = {};
  int selectedRideOption = -1;
  bool isMinivanSelected = false;

  @override
  Widget build(BuildContext context) {
    final GoogleMaps.CameraPosition initialCameraPosition =
    GoogleMaps.CameraPosition(
      target: GoogleMaps.LatLng(
        (widget.pickupLocationLatitude + widget.dropOffLocationLatitude) / 2,
        (widget.pickupLocationLongitude + widget.dropOffLocationLongitude) / 2,
      ),
      zoom: 15.0,
    );

    final GoogleMaps.LatLng pickupLatLng =
    GoogleMaps.LatLng(widget.pickupLocationLatitude, widget.pickupLocationLongitude);
    final GoogleMaps.LatLng dropOffLatLng =
    GoogleMaps.LatLng(widget.dropOffLocationLatitude, widget.dropOffLocationLongitude);

    final GoogleMaps.Polyline polyline = GoogleMaps.Polyline(
      polylineId: GoogleMaps.PolylineId('route'),
      color: Colors.red,
      width: 3,
      points: [pickupLatLng, dropOffLatLng],
    );

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: isMinivanSelected ? 3 : 3, // Expand the map when Minivan is selected
            child: Stack(
              children: [
                GoogleMaps.GoogleMap(

                  initialCameraPosition: initialCameraPosition,
                  markers: {
                    GoogleMaps.Marker(
                      markerId: GoogleMaps.MarkerId('pickup'),
                      position: pickupLatLng,
                      icon: GoogleMaps.BitmapDescriptor.defaultMarkerWithHue(
                          GoogleMaps.BitmapDescriptor.hueCyan),
                    ),
                    GoogleMaps.Marker(
                      markerId: GoogleMaps.MarkerId('drop-off'),
                      position: dropOffLatLng,
                      icon: GoogleMaps.BitmapDescriptor.defaultMarkerWithHue(
                          GoogleMaps.BitmapDescriptor.hueBlue),
                    ),
                  },
                  polylines: {polyline},
                  zoomControlsEnabled: false,
                  mapType: GoogleMaps.MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                ),

              ],
            ),
          ),
          SizedBox(height: 20,),

          Container(
            height: 200.0,
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(


              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  String rideTitle = '';
                  String rideSubtitle = '';
                  String imagePath = '';

                  switch (index) {
                    case 0:
                      rideTitle = 'Minivan';
                      rideSubtitle = 'Capacity: 6-8 people';
                      imagePath = 'assets/images/car.jpeg';
                      break;
                    case 1:
                      rideTitle = 'Economy';
                      rideSubtitle = 'Capacity: 4-5 people';
                      imagePath = 'assets/images/car.jpeg';
                      break;
                    case 2:
                      rideTitle = 'Premium';
                      rideSubtitle = 'Capacity: 2-3 people';
                      imagePath = 'assets/images/car.jpeg';
                      break;
                    case 3:
                      rideTitle = 'Other';
                      rideSubtitle = 'Capacity: Varies';
                      imagePath = 'assets/images/car.jpeg';
                      break;
                  }


                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRideOption = index;
                        isMinivanSelected = index == 0; // Expand the map if Minivan is selected
                      });
                    },
                    child: Card(
                      elevation: selectedRideOption == index ? 4.0 : 2.0,
                      color: selectedRideOption == index ? Colors.blueAccent : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: 150.0,
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                              Image.asset(
                                imagePath,
                                width: 60,
                                height: 60,
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                rideTitle,
                                style: TextStyle(
                                  color: selectedRideOption == index ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                rideSubtitle,
                                style: TextStyle(
                                  color:selectedRideOption == index ? Colors.white : Colors.black,
                                ),
                              ),
                            ],

                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedRideOption != -1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmPage(
                      pickupLocation: widget.pickupLocation,
                      dropOffLocation: widget.dropOffLocation,
                      pickupLocationLatitude: widget.pickupLocationLatitude,
                      pickupLocationLongitude: widget.pickupLocationLongitude,
                      dropOffLocationLatitude: widget.dropOffLocationLatitude,
                      dropOffLocationLongitude: widget.dropOffLocationLongitude,
                      phoneNumber: widget.phoneNumber,
                      selectedDateTime: widget.selectedDateTime,
                      rideOption: selectedRideOption,
                    ),
                  ),
                );
              }
            },
            child: Text('Confirm'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}