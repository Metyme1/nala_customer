import 'dart:async';
import 'package:flutter/material.dart';
import '../../config/platte.dart';
import 'Name.dart';

class OTPPage extends StatefulWidget {
  final String phoneNumber;

  const OTPPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  late List<FocusNode> focusNodes;
  late List<TextEditingController> controllers;
  late List<String> otpValues;
  int otpCountdown = 45; // Countdown timer value for OTP verification
  int resendCountdown = 45; // Countdown timer value for resend button
  Timer? otpTimer;
  Timer? resendTimer;
  @override
  void initState() {
    super.initState();

    focusNodes = List<FocusNode>.generate(4, (index) => FocusNode());
    controllers = List<TextEditingController>.generate(
      4,
          (index) => TextEditingController(),
    );
    otpValues = List<String>.generate(4, (index) => '');

  }

  @override
  void dispose() {

    for (int i = 0; i < 4; i++) {
      focusNodes[i].dispose();
      controllers[i].dispose();
    }
    otpTimer?.cancel();
    resendTimer?.cancel();
    super.dispose();

  }

  void startResendTimer() {
    const oneSec = Duration(seconds: 1);
    resendTimer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (resendCountdown == 0) {
          timer.cancel();
          // Handle resend timer expired
        } else {
          setState(() {
            resendCountdown--;
          });
        }
      },
    );
  }


  void _onTextChanged(int index, String value) {
    otpValues[index] = value;

    if (value.isNotEmpty && index < 3) {
      focusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }

    setState(() {}); // Update the UI

    if (index == 3 && value.isNotEmpty) {
      // Perform OTP verification logic here
      String enteredOtp = otpValues.join('');

      // Replace 'sentOtpCode' with the actual OTP code sent to the user
      String sentOtpCode = '1234'; // Replace with your actual sent OTP code

      if (enteredOtp == sentOtpCode) {
        // OTP code is valid
        Navigator.push(
          context,
          MaterialPageRoute(
             builder: (context) =>EnterFullNamePage(phoneNumber: widget.phoneNumber, FullName: '',),

          ),
        );
      } else {
        // Invalid OTP code
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid OTP'),
              content: Text('The entered OTP code is incorrect. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  String formatCountdownTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String formattedTime = '';

    if (minutes > 0) {
      formattedTime += minutes.toString().padLeft(2, '0') + ':';
    }

    formattedTime += remainingSeconds.toString().padLeft(2, '0');

    return formattedTime;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("otp code"),
      backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(

        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          4,
                              (index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: SizedBox(
                              width: 48,
                              height: 60, // Increase the height of the boxes
                              child: TextField(
                                controller: controllers[index],
                                focusNode: focusNodes[index],
                                onChanged: (value) => _onTextChanged(index, value),
                                maxLength: 1,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 24),
                                decoration: InputDecoration(
                                  counterText: '',
                                  filled: true,
                                  fillColor: otpValues[index].isNotEmpty
                                      ? AppColors.primaryColor
                                      : Colors.grey[200], // Customize colors
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      Text(
                        'we have sent confirmation code to your phone\n${widget.phoneNumber}',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),


                      SizedBox(height: 16),
                      Container(
                        width: 300.0, // Set the desired width
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(50.0)),
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        
                      ),
                        SizedBox(height: 30,),

                      // Countdown timer for resend button
                      Text(
                        "Resend code in  $resendCountdown sec",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}