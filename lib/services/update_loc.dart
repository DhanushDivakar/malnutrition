import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class UpdateLocation extends StatefulWidget {
  const UpdateLocation({super.key});

  @override
  State<UpdateLocation> createState() => _UpdateLocationState();
}

class _UpdateLocationState extends State<UpdateLocation> {
  final TextEditingController _aadharNumberController = TextEditingController();
  String? aadharNumber;
  String? _currentAddress;
  final _formKey = GlobalKey<FormState>();
  final CollectionReference childrenCollection =
      FirebaseFirestore.instance.collection('children_details');

  String? _selectedCondition;

  Future<QuerySnapshot<Map<String, dynamic>>> getChildData(
      String aadharNumber) async {
    final QuerySnapshot<Map<String, dynamic>> childSnapshot =
        await childrenCollection
            .where('aadharNumber', isEqualTo: aadharNumber)
            .get() as QuerySnapshot<Map<String, dynamic>>;
    return childSnapshot;
  }

  final List<String> _condition = <String>[
    'Normal',
    'Mild malnutrition',
    'Moderate malnutrition',
    'Severe malnutrition',
  ];

  bool isLoading = false;
  bool isLoadingg = false;
  bool? serviceEnabled;
  String? postalCode;
  LocationPermission? permission;

  Position? _currentPosition;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoadingg = true;
      });
      print(isLoadingg);
      Navigator.pop(context);
      FocusScope.of(context).unfocus();

      await Geolocator.requestPermission();

      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled!) {
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
          setState(() {
            isLoadingg = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permissions are denied')));
        }
      }
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        setState(() => _currentPosition = position);
        placemarkFromCoordinates(
                _currentPosition!.latitude, _currentPosition!.longitude)
            .then((List<Placemark> placemarks) {
          Placemark place = placemarks[0];
          setState(() {
            postalCode = place.postalCode;
            _currentAddress =
                '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
          });
          FirebaseFirestore.instance.collection('location_history').add({
            'aadharNumber': aadharNumber,
            'address': _currentAddress,
            'condition': _selectedCondition,
            'time': DateTime.now(),
            'postalCode': postalCode
          }).catchError((e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to add child')),
            );
          });
          print(aadharNumber);
          print(_currentAddress);
          print(_selectedCondition);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Updated sucessfully')),
          );

          setState(() {
            isLoadingg = false;
          });
          print(isLoadingg);
        }).catchError((e) {
          debugPrint(e);
        });
        print(position.latitude);
        print(position.longitude);
      }).catchError((e) {
        debugPrint(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //final TextEditingController descriptionController = TextEditingController();
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Aadhaar'),
      ),
      body: isLoadingg
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    maxLength: 12,
                    controller: _aadharNumberController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (String value) async {
                      FocusScope.of(context).unfocus();
                      final String aadharNumberCo =
                          _aadharNumberController.text.trim();
                      isLoading = true;
                      final CollectionReference collectionReference =
                          FirebaseFirestore.instance
                              .collection('location_history');
                      Query query = collectionReference
                          .where('aadharNumber', isEqualTo: aadharNumberCo)
                          .orderBy('time', descending: true)
                          .limit(1);
                      QuerySnapshot querySnapshot = await query.get();
                      final docData =
                          querySnapshot.docs.map((doc) => doc.data()).toList();

                      if (docData.isNotEmpty) {
                        print("found");
                        isLoading = false;
                        setState(() {
                          aadharNumber = aadharNumberCo;
                        });
                      } else {
                        isLoading = false;
                        print("not found");

                        setState(() {
                          aadharNumber = null;
                        });
                      }
                      if (docData.isNotEmpty) {
                        final QuerySnapshot<Map<String, dynamic>>
                            childSnapshot = await getChildData(aadharNumber!);
                        final childData = childSnapshot.docs[0].data();
                        isLoading
                            ? const CircularProgressIndicator()
                            // ignore: use_build_context_synchronously
                            : showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: SizedBox(
                                      height: height * 0.6,
                                      child: Form(
                                        key: _formKey,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          elevation: 4,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            childData[
                                                                'childName'],
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 4),
                                                          Text(
                                                            childData['gender'],
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                Text(
                                                  'Aadhaar Number: ${childData['aadharNumber']}',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'Guardian Name: ${childData['guardianName']}',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'Previous Location: ${childData['address']}',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                const Text(
                                                    'Select the current condition of child'),
                                                const SizedBox(height: 8),
                                                DropdownButtonFormField<String>(
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Condition',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  validator: (value) {
                                                    if (_selectedCondition ==
                                                        null) {
                                                      return 'Please select an option';
                                                    }
                                                    return null;
                                                  },
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  value: _selectedCondition,
                                                  enableFeedback: true,
                                                  items: _condition
                                                      .map((gender) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: gender,
                                                            child: Text(gender),
                                                          ))
                                                      .toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedCondition =
                                                          value;
                                                    });
                                                    print(_selectedCondition);
                                                  },
                                                  isExpanded: true,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: ElevatedButton(
                                                      onPressed: _submitForm,
                                                      child:
                                                          const Text('Update'),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                      } else {
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                title: const Text('Search'),
                                content: Text(
                                    'Aadhaar number ${_aadharNumberController.text} not found, please register'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Go Back'),
                                  )
                                ],
                              );
                            });
                      }

                      // Do something with the submitted value
                    },
                    decoration: const InputDecoration(
                      labelText: 'Aadhaar Number',
                      hintText: 'Aadhaar Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
    );
  }
}
