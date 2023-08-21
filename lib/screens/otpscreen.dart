import 'package:flutter/material.dart';
import 'package:nala_c/screens/splash_screens/splash.dart';

import 'map.dart';

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
    super.dispose();
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
      String otp = otpValues.join('');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapPage(phoneNumber: widget.phoneNumber),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff1C6AC5), Color(0xffD1D1D6)],
            stops: [0.0, 1.2],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context); // Navigate back to previous page
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: Text(
                      //     'Phone Verification',
                      //     style: TextStyle(
                      //       fontSize: 24,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                      Text(
                        'we have sent OTP to your phone\n${widget.phoneNumber}',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          4,
                              (index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: SizedBox(
                              width: 48,
                              height: 48,
                              child: TextField(
                                controller: controllers[index],
                                focusNode: focusNodes[index],
                                onChanged: (value) =>
                                    _onTextChanged(index, value),
                                maxLength: 1,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 24),
                                decoration: InputDecoration(
                                  counterText: '',
                                  filled: true,
                                  fillColor: otpValues[index].isNotEmpty
                                      ? Colors.blue
                                      : Colors.white,
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
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            // Implement resend code logic here
                            // Refresh the UI if needed
                            otpValues = List<String>.generate(4, (index) => '');
                            for (var controller in controllers) {
                              controller.clear();
                            }
                          });
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Didn't get code? ",
                            style: TextStyle(color: Colors.white),
                            children: [
                              TextSpan(
                                text: "Resend",
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
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