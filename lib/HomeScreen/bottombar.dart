import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:malnutrition/HomeScreen/home_screen.dart';
import 'package:malnutrition/profile/profile.dart';
import 'package:malnutrition/services/loc_history.dart';

import '../services/data_location.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    LocHistory(),
    DataBasedOnLocation(),
    MyProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void requestPermission() async {
    bool? serviceEnabled;
    Position? _currentPosition;
    LocationPermission? permission;
    await Geolocator.requestPermission();

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Geolocator.requestPermission();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please turn on location')),
      );
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied &&
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor: Colors.yellow),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Data Location',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.blue,
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        elevation: 5,
      ),
    );
  }
}
