import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AddChild extends StatefulWidget {
  const AddChild({super.key});

  @override
  State<AddChild> createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  final _formKey = GlobalKey<FormState>();
  String? _childName, _aadharNumber, _guardianName;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
    Geolocator.openLocationSettings();
  }

  String? _currentAddress;
  Position? _currentPosition;
  Future<void> _getCurrentPosition() async {
    final hasPermission = await getLocation();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
      print(position.latitude);
      print(position.longitude);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    await Geolocator.requestPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        if (_currentAddress != null) {
          _getCurrentPosition;

          await FirebaseFirestore.instance.collection('children_details').add({
            'childName': _childName,
            'aadharNumber': _aadharNumber,
            'guardianName': _guardianName,
            'address': _currentAddress,
          });
          print(_childName);
          print(_aadharNumber);
          print(_guardianName);
          print(_currentAddress);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Child added successfully')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add child')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Child'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Child Name as in Aadhar Card'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _childName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Aadhar Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a number';
                  }
                  if (!RegExp(r'^[2-9]{1}[0-9]{3}[0-9]{4}[0-9]{4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid 12-digit Aadhar number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _aadharNumber = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Guardian Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _guardianName = value!;
                },
              ),
              SizedBox(height: 16),
              if (_currentAddress != null)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('LAT: ${_currentPosition?.latitude ?? ""}'),
                    Text('LNG: ${_currentPosition?.longitude ?? ""}'),
                    Text('ADDRESS: ${_currentAddress ?? ""}'),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text("Get Current Location"),
                    )
                  ],
                ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Get Current Location"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
