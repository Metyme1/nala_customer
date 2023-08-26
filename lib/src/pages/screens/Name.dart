import 'package:flutter/material.dart';
import '../../widget/AppBoldText.dart';
import '../../widget/AppText.dart';
import '../../widget/button.dart';
import '../splash_screens/splash.dart';
import 'Homepage.dart';

class EnterFullNamePage extends StatelessWidget {
  final String phoneNumber;
  final String FullName;

  const EnterFullNamePage({Key? key, required this.phoneNumber, required this.FullName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            SizedBox(height: 46.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
            ),
            SizedBox(height: 25,),
            AppText(
              text: 'Enter Your Full Name',
            ),
            SizedBox(height: 46.0),

            Buttons().longButton('Next', () {
              {
                // Show a dialog or perform any necessary actions

                // Navigate to the desired page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MapPage(phoneNumber: phoneNumber, FullName: FullName,)
                  ),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}