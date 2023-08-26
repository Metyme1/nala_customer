// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapWidget extends StatelessWidget {
//   final LatLng center;
//   final BitmapDescriptor? markerIcon;
//   final GlobalKey<ScaffoldState> scaffoldKey;
//
//   const MapWidget({
//     Key? key,
//     required this.center,
//     this.markerIcon,
//     required this.scaffoldKey,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         if (center != null)
//           maps.GoogleMap(
//             initialCameraPosition: maps.CameraPosition(
//               target: center,
//               zoom: 15.0,
//             ),
//             mapType: maps.MapType.normal,
//             markers: {
//               if (markerIcon != null) // Check if the marker icon is loaded
//                 maps.Marker(
//                   markerId: maps.MarkerId('current_location'),
//                   position: center,
//                   icon: markerIcon!,
//                   anchor: Offset(0.5, 0.5),
//                 ),
//             },
//             myLocationEnabled: true, // Enable the "My Location" button
//             myLocationButtonEnabled: false, // Hide the default "My Location" button
//             zoomControlsEnabled: false, // Hide the zoom controls
//             compassEnabled: true, // Show the compass
//             onMapCreated: (maps.GoogleMapController controller) {
//               // Optional: You can customize the map controller settings here
//             },
//           ),
//         Positioned(
//           top: 46.0,
//           left: 16.0,
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white,
//                 ),
//                 child: IconButton(
//                   icon: Icon(Icons.menu),
//                   onPressed: () {
//                     scaffoldKey.currentState?.openDrawer(); // Open the drawer when the menu button is pressed
//                   },
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               // Add additional widgets as needed
//             ],
//           ),
//         ),
//         Positioned(
//           top: 46.0,
//           right: 16.0,
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white,
//                 ),
//                 child: IconButton(
//                   icon: Icon(Icons.person),
//                   onPressed: () {
//                     // Add your navigation logic here
//                   },
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               // Add additional widgets as needed
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }