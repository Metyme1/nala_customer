import 'package:flutter/material.dart';
import 'package:nala_c/src/pages/screens/pickup_drop.dart';

class ConfirmationPage extends StatelessWidget {
  final String phoneNumber;
  final String fullName;
  final String rideType;
  final String selectedCarOption;

  ConfirmationPage({
    required this.phoneNumber,
    required this.fullName,
    required this.rideType,
    required this.selectedCarOption,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirmation Details:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text('Phone Number: $phoneNumber'),
            SizedBox(height: 8.0),
            Text('Full Name: $fullName'),
            SizedBox(height: 8.0),
            Text('Ride Type: $rideType'),
            SizedBox(height: 8.0),
            Text('Selected Car Option: ${selectedCarOption}'),
          ],
        ),
      ),
    );
  }
}