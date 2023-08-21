import 'package:flutter/material.dart';

class Buttons {
  // long button
  Widget longButton(title, void Function() onPressed) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      child: Container(
        padding: const EdgeInsets.all(5.0),
        height: 60,
        // width: 350,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xff1C6AC5)),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontFamily: 'Ubuntu',
            ),
          ),
        ),
      ),
    );
  }

// popup button

}