import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:nala_c/src/config/platte.dart';
import 'Rideshare/chooseRide.dart';
import 'Search.dart';


class MyHomePage extends StatefulWidget {
  final String phoneNumber;
  final int rideType;
  final String FullName;

  MyHomePage({required this.phoneNumber, required   this.rideType, required this.FullName});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _pickUpController = TextEditingController();
  final TextEditingController _dropOffController = TextEditingController();
  final TextEditingController _passengerController = TextEditingController();

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

  List<CarOption> carOptions = [
    CarOption(
      name: 'Minivan',
      icon: Icons.directions_car,
      capacity: 7,
    ),
    CarOption(
      name: 'Economy',
      icon: Icons.directions_car,
      capacity: 4,
    ),
    CarOption(
      name: 'Luxury',
      icon: Icons.directions_car,
      capacity: 2,
    ),

  ];
  CarOption? selectedCarOption;
  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatter = DateFormat('MMMM dd, yyyy');
    final DateFormat timeFormatter = DateFormat('hh:mm a');

    final String formattedDate = dateFormatter.format(_selectedDateTime);
    final String formattedTime = timeFormatter.format(_selectedDateTime);

    return Scaffold(

      body: Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height,
        color: AppColors.backgroundColor,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 16),
            Container(
              width: 380,
              height: 300,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                // Add any other required properties
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),

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
                                  _pickUpController.text = _extractCityAndCountry(
                                      suggestion);
                                });

                              },
                            ),
                          ),
                        ),
                        if (_selectedPickUpLocation.isNotEmpty)
                          IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: _cancelPickUpSelection,
                          ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1,
                              )
                            ),
                            child: Expanded(
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
                                    hintText: 'Choose drop-off location',
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

                                },
                              ),
                            ),
                          ),
                        ),

                        if (_selectedDropOffLocation.isNotEmpty)
                          IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: _cancelDropOffSelection,
                          ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        InkWell(
                          onTap: _selectDateTime,
                          child: Icon(
                            Icons.calendar_today,
                            color: Colors.black,
                            size: 20.0,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 130,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1,
                            )
                          ),
                          child: Center(
                            child: Text(
                              formattedDate,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1,
                              )
                          ),
                          child: Center(
                            child: Text(
                              formattedTime, // Replace 'formattedTime' with your actual time variable
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Add any additional widgets as required
                  ],
                ),
              ),
            ),
            Center(
              child: Text(
                "Choose Ride option",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.26,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: carOptions.length,
                itemBuilder: (context, index) {
                  final carOption = carOptions[index];
                  final isSelected = selectedCarOption == carOption;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCarOption = carOption;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: 120,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            carOption.icon,
                            size: 40,
                            color: isSelected ? Colors.white : Colors.black38,
                          ),
                          SizedBox(height: 10),
                          Text(
                            carOption.name,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black38,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${carOption.capacity} people',
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black38,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 154),

            Container(
              width: 500.0, // Set the desired width
              child: ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog(context);
                },
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
                  'Book a ride',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),

            ),

          ],
        ),
      )
    );

  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            title: Text('Confirm your order'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Phone Number: ${widget.phoneNumber}'),
                SizedBox(height: 8.0),
                Text('Full Name: ${widget.FullName}'),
                SizedBox(height: 8.0),
                Text('Ride Type: ${widget.rideType}'),
                SizedBox(height: 8.0),
                Text('Selected Car Option: $selectedCarOption'),
                SizedBox(height: 16.0),
                Text('Date: ${DateTime.now()}'),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (widget.rideType == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Shared(
                          phoneNumber: widget.phoneNumber,
                          fullName: widget.FullName,
                          selectedCarOption: '', rideType: "Shared Ride",
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchingPage(
                          phoneNumber: widget.phoneNumber,
                          fullName: widget.FullName,
                          selectedCarOption: '', rideType: "Normal Ride",
                        ),
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                  minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(50.0)),
                ),
                child: Text('Confirm'),
              ),
            ],
          ),
        );
      },
    );
  }

}

class CarOption {
  final String name;
  final IconData icon;
  final int capacity;

  CarOption({
    required this.name,
    required this.icon,
    required this.capacity,
  });
}

