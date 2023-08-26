import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/platte.dart';
import '../../widget/AppBoldText.dart';
import '../../widget/button.dart';

import 'Otp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneNumberController = TextEditingController();

  // void sendOtpCode(String phoneNumber) {
  //   // Call your OTP service or API to send the OTP code to the provided phone number
  //   // You can replace 'YourOTPService' with the actual service or API class you are using
  //   YourOTPService.sendOTP(phoneNumber); // Replace 'YourOTPService' with your actual service or API class
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: Align(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        // Navigate back or perform any other action
                      },
                    ),
                    AppBoldText(
                      text: 'Enter Phone Number',
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28.0, vertical: 5.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextField(
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 17,
                      ),
                      decoration: InputDecoration(
                        prefixText: '+251 ',
                        hintText: 'Enter your phone number',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0), // Add border radius here
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(10.0), // Add border radius here
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(10.0), // Add border radius here

                        )
                      )
                    )
                  ),
                ),

                const SizedBox(
                  height: 35,
                ),
                Text(
                  'We will send an SMS Code to verify your\nphone number',
                ),
                SizedBox(
                  height: 30,
                ),
            Buttons().longButton('Continue', () {
              if (phoneNumberController.text.isNotEmpty) {
                // Show a dialog or perform any necessary actions

                // Navigate to the desired page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OTPPage(phoneNumber: phoneNumberController.text)
                  ),
                );
              }
            })
              ],
            ),
          ),
        ),
      ),
    );
  }
}