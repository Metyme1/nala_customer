import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:nala_c/screens/ride.dart';

class MyHomePage extends StatefulWidget {
  final String phoneNumber;

  MyHomePage({required this.phoneNumber});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _pickUpController = TextEditingController();
  final TextEditingController _dropOffController = TextEditingController();

  List<String> _pickUpSuggestions = [];
  List<String> _dropOffSuggestions = [];

  String _selectedPickUpLocation = '';
  String _selectedDropOffLocation = '';

  Future<List<String>> _getLocationSuggestions(String query) async {
    String url = "https://nr-get-locations-api.vercel.app/api/locations";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['response'];
        Set<String> citySuggestions = Set<String>();
        for (var location in data) {
          String cityName = location['city'];
          String zone = location['zone'];
          String title = location['title'];

          // Perform null checks before creating the suggestion
          if (cityName != null &&
              cityName.toLowerCase().contains(query.toLowerCase())) {
            String suggestion = '$cityName | $zone | $title';
            citySuggestions.add(suggestion);
          }
        }

        if (query.isEmpty) {
          citySuggestions = data.map<String>((location) {
            String cityName = location['city'];
            String zone = location['zone'];
            String title = location['title'];
            return '$title\n$cityName,$zone,Ethiopia';
          }).toSet();
        }
        return citySuggestions.toList(); // Convert Set to List for suggestions
      } else {
        throw Exception('Failed to load location suggestions');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  DateTime _selectedDateTime = DateTime.now();

  Future<void> _selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _navigateToChoosingRidePage() {
    if (_selectedPickUpLocation.isNotEmpty &&
        _selectedDropOffLocation.isNotEmpty &&
        _selectedDateTime != null) { // Assuming you have a variable named selectedDateTime for storing the chosen date and time
      double pickupLatitude = 9.0108; // Latitude for pickup location in Addis Ababa
      double pickupLongitude = 38.7610; // Longitude for pickup location in Addis Ababa
      double dropOffLatitude = 8.9806; // Latitude for drop-off location in Addis Ababa
      double dropOffLongitude = 38.7578; // Longitude for drop-off location in Addis Ababa

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChoosingRidePage(
            pickupLocation: _selectedPickUpLocation,
            dropOffLocation: _selectedDropOffLocation,
            pickupLocationLatitude: pickupLatitude,
            pickupLocationLongitude: pickupLongitude,
            dropOffLocationLatitude: dropOffLatitude,
            dropOffLocationLongitude: dropOffLongitude,
            selectedDateTime: _selectedDateTime, // Pass the selected date and time to ChoosingRidePage
            phoneNumber: widget.phoneNumber,
          ),
        ),
      );
    }
  }

  String _extractCityAndCountry(String suggestion) {
    List<String> parts = suggestion.split(',');
    if (parts.length >= 2) {
      String city = parts[1];
      // String country = parts[1].trim();
      return '$city, Ethiopia';
    }
    return suggestion;
  }


  void _cancelPickUpSelection() {
    setState(() {
      _selectedPickUpLocation = '';
      _pickUpController.text = '';
    });
  }

  void _cancelDropOffSelection() {
    setState(() {
      _selectedDropOffLocation = '';
      _dropOffController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat(
        'MMMM dd, yyyy - hh:mm a'); // Define the date format
    final String formattedDate = formatter.format(
        _selectedDateTime); // Format the selected date

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.blueAccent,
                  size: 10.0,
                ),
                SizedBox(width: 5.0),
                Text(
                  'Pick-up Location:'.tr(),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TypeAheadFormField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _pickUpController,
                        onChanged: (value) {
                          _getLocationSuggestions(value).then((suggestions) {
                            setState(() {
                              _pickUpSuggestions = suggestions;
                            });
                          }).catchError((error) {
                            print(
                                'Error fetching pick-up location suggestions: $error');
                          });
                        },
                        decoration: InputDecoration.collapsed(
                          hintText: 'Enter pick-up location',
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        return _getLocationSuggestions(pattern);
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        setState(() {
                          _selectedPickUpLocation = suggestion;
                          _pickUpController.text =
                              _extractCityAndCountry(suggestion);
                        });
                        _navigateToChoosingRidePage();
                      },
                    ),
                  ),
                  if (_selectedPickUpLocation.isNotEmpty)
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: _cancelPickUpSelection,
                    ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 10.0,
                ),
                SizedBox(width: 5.0),
                Text(
                  'Drop-off Location:'.tr(),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TypeAheadFormField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _dropOffController,
                        onChanged: (value) {
                          _getLocationSuggestions(value).then((suggestions) {
                            setState(() {
                              _dropOffSuggestions = suggestions;
                            });
                          }).catchError((error) {
                            print(
                                'Error fetching drop-off location suggestions: $error');
                          });
                        },
                        decoration: InputDecoration.collapsed(
                          hintText: 'Enter drop-off location',
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        return _getLocationSuggestions(pattern);
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        setState(() {
                          _selectedDropOffLocation = suggestion;
                          _dropOffController.text =
                              _extractCityAndCountry(suggestion);
                        });
                        _navigateToChoosingRidePage();
                      },
                    ),
                  ),
                  if (_selectedDropOffLocation.isNotEmpty)
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: _cancelDropOffSelection,
                    ),
                ],
              ),
            ),
            SizedBox(height: 50),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.blueAccent,
                        size: 30.0,
                      ),

                      SizedBox(width: 8),
                      Text(
                        'Choose pickup Date'.tr(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    formattedDate,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),


                  ElevatedButton(
                    onPressed: _selectDateTime,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    child: Text(
                      'Change Date and Time',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),


                ],
              ),
            ),

          ),

      ]
        )
      ),
    );
  }

}

