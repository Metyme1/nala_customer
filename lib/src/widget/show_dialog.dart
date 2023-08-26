import 'package:flutter/material.dart';

import '../pages/screens/login.dart';


class ShowDialogWidget {
  Future showDialogWidget(
      BuildContext context, String title, String phone, void Function() onTapOK) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          phone,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  // Call the provided callback function
                  onTapOK();

                  // Navigate to the OTP page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffffffff)),
                ),
                child: const Text(
                  'Edit',
                  style: TextStyle(color: Color(0xff1C6AC5)),
                ),
              ),
              // TextButton(
              //   onPressed: () {
              //     // Call the provided callback function
              //     onTapOK();
              //
              //     // Navigate to the OTP page
              //     Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(builder: (context) => OTPPage(phoneNumber: phone)),
              //     );
              //   },
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff1C6AC5)),
              //   ),
              //   child: const Text(
              //     'Yes',
              //     style: TextStyle(color: Color(0xffffffff)),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}