import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Navigate to the Home page
              Navigator.pop(context);
              // Add your navigation logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Navigate to the Settings page
              Navigator.pop(context);
              // Add your navigation logic here
            },
          ),
          // Add more items to the drawer as needed
        ],
      ),
    );
  }
}


// Container(
// width: 250.0, // Set the desired width for the drawer
// child: Drawer(
// backgroundColor: Colors.white, // Change the background color to white
// child: ListView(
// padding: EdgeInsets.zero,
// children: [
// DrawerHeader(
// decoration: BoxDecoration(
// color: Colors.white, // Change the header background color to black
// borderRadius: BorderRadius.only(
// bottomLeft: Radius.circular(20.0),
// bottomRight: Radius.circular(20.0),
// ),
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Row(
// children: [
// Container(
// width: 60.0,
// height: 60.0,
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// color: Colors.blue,
// ),
// child: CircleAvatar(
// backgroundColor: Colors.transparent,
// child: Icon(
// Icons.person,
// color: Colors.black,
// size: 40.0,
// ),
// ),
// ),
// SizedBox(width: 10.0),
// Text(
// widget.phoneNumber,
// style: TextStyle(
// color: Colors.black,
// fontSize: 16,
// fontWeight: FontWeight.bold,
// ),
// ),
// ],
// ),
// SizedBox(height: 10.0),
//
// ],
// ),
// ),
// ListTile(
// leading: Icon(
// Icons.wallet,
// color: Colors.black, // Change the icon color to black
// size: 24.0,
// ),
// title: Text(
// 'Wallet'.tr(),
// style: TextStyle(
// color: Colors.black54, // Change the text color to black
// fontSize: 18,
// fontFamily: 'Poppins',
// ),
// ),
// onTap: () {
// // Handle item 1 tap
// },
// ),
// ListTile(
// leading: Icon(
// Icons.notification_important,
// color: Colors.black, // Change the icon color to black
// size: 24.0,
// ),
// title: Text(
// 'Notifications'.tr(),
// style: TextStyle(
// color: Colors.black, // Change the text color to black
// fontSize: 18,
// fontFamily: 'Poppins',
// ),
// ),
// onTap: () {
// // Handle item 2 tap
// },
// ),
// ListTile(
// leading: Icon(
// Icons.history,
// color: Colors.black, // Change the icon color to black
// size: 24.0,
// ),
// title: Text(
// 'History'.tr(),
// style: TextStyle(
// color: Colors.black, // Change the text color to black
// fontSize: 18,
// fontFamily: 'Poppins',
// ),
// ),
// onTap: () {
// // Handle item 3 tap
// },
// ),
// SizedBox(height: 20.0),
// Container(
// margin: EdgeInsets.symmetric(horizontal: 10.0),
// child: Divider(
// color: Colors.black, // Change the divider color to black
// thickness: 1.0,
// ),
// ),
// SizedBox(height: 20.0),
// ListTile(
// leading: Icon(
// Icons.schedule,
// color: Colors.black, // Change the icon color to black
// size: 24.0,
// ),
// title: Text(
// 'Preorder'.tr(),
// style: TextStyle(
// color: Colors.black, // Change the text color to black
// fontSize: 18,
// fontFamily: 'Poppins',
// ),
// ),
// onTap: () {
// // Handle item 4 tap
// },
// ),
// ListTile(
// leading: Icon(
// Icons.car_rental,
// color: Colors.black, // Change the icon color to black
// size: 24.0,
// ),
// title: Text(
// 'Free Nala Mile'.tr(),
// style: TextStyle(
// color: Colors.black, // Change the text color to black
// fontSize: 18,
// fontFamily: 'Poppins',
// ),
// ),
// onTap: () {
// // Handle item 5 tap
// },
// ),
// ListTile(
// leading: Icon(
// Icons.feedback,
// color: Colors.black, // Change the icon color to black
// size: 24.0,
// ),
// title: Text(
// 'App Feedback'.tr(),
// style: TextStyle(
// color: Colors.black, // Change the text color to black
// fontSize: 18,
// fontFamily: 'Poppins',
// ),
// ),
// onTap: () {
// // Handle item 6 tap
// },
// ),
// ],
// ),
// ),
//
// ),