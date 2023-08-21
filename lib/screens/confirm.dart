import 'package:flutter/material.dart';
import 'preorder.dart';

class ConfirmPage extends StatelessWidget {
  final String pickupLocation;
  final String dropOffLocation;
  final double pickupLocationLatitude;
  final double pickupLocationLongitude;
  final double dropOffLocationLatitude;
  final double dropOffLocationLongitude;
  final String phoneNumber;
  final DateTime selectedDateTime;
  final int rideOption;

  ConfirmPage({
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
    final boldTextStyle = TextStyle(fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Ride'),
        backgroundColor: Colors.blueAccent
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pickup Location:',
                style: boldTextStyle,
              ),
              Text(pickupLocation),
              SizedBox(height: 8),
              Text(
                'Drop-off Location:',
                style: boldTextStyle,
              ),
              Text(dropOffLocation),
              SizedBox(height: 8),
              Text(
                'Ride Option:',
                style: boldTextStyle,
              ),
              Text(rideOption.toString()),
              SizedBox(height: 8),
              Text(
                'Phone Number:',
                style: boldTextStyle,
              ),
              Text(phoneNumber),
              SizedBox(height: 8),
              Text(
                'Date and Time:',
                style: boldTextStyle,
              ),
              Text(selectedDateTime.toString()),
              SizedBox(height: 16),
              // if (selectedDateTime != DateTime.now())
              //   ElevatedButton(
              //     onPressed: () {
              //       // Pass the order data to the preorder page
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => PreorderPage(
              //             pickupLocation: pickupLocation,
              //             dropOffLocation: dropOffLocation,
              //             pickupLocationLatitude: pickupLocationLatitude,
              //             pickupLocationLongitude: pickupLocationLongitude,
              //             dropOffLocationLatitude: dropOffLocationLatitude,
              //             dropOffLocationLongitude: dropOffLocationLongitude,
              //             phoneNumber: phoneNumber,
              //             selectedDateTime: selectedDateTime,
              //             rideOption: rideOption,
              //           ),
              //         ),
              //       );
              //     },
              //     child: Text('Preorder'),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}