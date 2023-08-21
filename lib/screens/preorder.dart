import 'package:flutter/material.dart';

class PreorderPage extends StatelessWidget {
  final String pickupLocation;
  final String dropOffLocation;
  final double pickupLocationLatitude;
  final double pickupLocationLongitude;
  final double dropOffLocationLatitude;
  final double dropOffLocationLongitude;
  final String phoneNumber;
  final DateTime selectedDateTime;
  final int rideOption;

  PreorderPage({
    required this.pickupLocation,
    required this.dropOffLocation,
    required this.pickupLocationLatitude,
    required this.pickupLocationLongitude,
    required this.dropOffLocationLatitude,
    required this.dropOffLocationLongitude,
    required this.phoneNumber,
    required this.selectedDateTime,
    required this.rideOption,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preorder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pickup Location:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(pickupLocation),
            SizedBox(height: 8),
            Text(
              'Drop-off Location:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(dropOffLocation),
            SizedBox(height: 8),
            Text(
              'Ride Option:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(rideOption.toString()),
            SizedBox(height: 8),
            Text(
              'Phone Number:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(phoneNumber),
            SizedBox(height: 8),
            Text(
              'Date and Time:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(selectedDateTime.toString()),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement your preorder logic here
              },
              child: Text('Confirm Preorder'),
            ),
          ],
        ),
      ),
    );
  }
}