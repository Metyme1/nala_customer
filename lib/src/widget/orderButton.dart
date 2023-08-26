import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nala_c/src/config/platte.dart';

import '../pages/screens/pickup_drop.dart';

GestureDetector buildOrderButton(BuildContext context, String phoneNumber, int rideTypeValue,String FullName) {
  return GestureDetector(
    onTap: () {
      String rideType = (rideTypeValue == 0) ? 'Shared Ride' : 'Normal Ride';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            phoneNumber: phoneNumber,
            rideType: rideType, FullName: FullName
          ),
        ),
      );
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, AppColors.primaryColor],
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
  );
}