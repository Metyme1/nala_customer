
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nala_c/screens/splash_screens/splash.dart';

import '../widget/button.dart';
import '../widget/show_dialog.dart';
import 'otpscreen.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState(
  );


}

class _LoginPageState extends State<LoginPage> {

  final phoneNumberController = TextEditingController();

  Map<String, bool> checkboxValues = {
    'Agree to terms and services': false,
    'Send me offers on services': false,
  };
  void handleCheckboxValueChanged(String label, bool? newValue) {
    if (newValue != null) {
      setState(() {
        checkboxValues[label] = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff1C6AC5), Color(0xffD1D1D6)],
          stops: [0.0, 1.2],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Phone Verfication',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Ubuntu',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                width: 350,
                child: Text(
                  'Please enter your phone number to use in this app',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // input field(TextField)
              Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25.0, top: 5.0, bottom: 5.0),
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: phoneNumberController,
                    // input type
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .digitsOnly // Accept only digits
                    ],
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 17,
                    ),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      hintText: 'Enter your phone number',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: checkboxValues.keys.map((String label) {
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                    value: checkboxValues[label],
                    onChanged: (bool? newValue) {
                      handleCheckboxValueChanged(label, newValue);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 10,
              ),

              Buttons().longButton('send Verfication', () {
                if (phoneNumberController.text.isNotEmpty) {
                  ShowDialogWidget().showDialogWidget(context,
                      'is this your number?', phoneNumberController.text, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SplashScreen(),
                          ),
                        );
                      });
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}