import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class DataBasedOnLocation extends StatefulWidget {
  const DataBasedOnLocation({super.key});

  @override
  State<DataBasedOnLocation> createState() => _DataBasedOnLocationState();
}

class _DataBasedOnLocationState extends State<DataBasedOnLocation> {
  List<Map<String, dynamic>> uniqueData = [];
  bool isLoading = false;

  bool? serviceEnabled;
  String? postalCode;
  Position? _currentPosition;
  LocationPermission? permission;

  void _getPostalCode() async {
    setState(() {
      isLoading = true;
    });

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
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
      }
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      placemarkFromCoordinates(
              _currentPosition!.latitude, _currentPosition!.longitude)
          .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        setState(() {
          postalCode = place.postalCode;
        });

        setState(() {
          isLoading = false;
        });
      }).catchError((e) {
        debugPrint(e);
      });
      print(position.latitude);
      print(position.longitude);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> displayUniqueData() async {
    // Get a reference to the collection
    CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('location_history');

    // Create a set to keep track of unique aadhar numbers
    Set<String> uniqueAadharNumbers = {};

    // Query the collection for all documents
    QuerySnapshot<Map<String, dynamic>> snapshot = await collection
        .where('postalCode', isEqualTo: postalCode)
        .orderBy('time', descending: true)
        .get();

    // Iterate over the documents and display only the unique ones
    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
        in snapshot.docs) {
      String aadharNumber = documentSnapshot.data()['aadharNumber'];
      if (!uniqueAadharNumbers.contains(aadharNumber)) {
        uniqueAadharNumbers.add(aadharNumber);
        setState(() {
          uniqueData.add(documentSnapshot.data());
        });
      }
    }
  }
  // Future<void> _fetchData() async {
  //   final collectionReference =
  //       FirebaseFirestore.instance.collection('location_history');
  //   final query = collectionReference
  //       .where('aadharNumber', isEqualTo: _aadharNumber)
  //       .orderBy('time', descending: true);
  //   final querySnapshot = await query.get();
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _getPostalCode();
    displayUniqueData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unique Data'),
      ),
      body: ListView.builder(
        itemCount: uniqueData.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> data = uniqueData[index];
          DateTime date =
              DateTime.fromMillisecondsSinceEpoch(data['time'].seconds * 1000);
          String formattedDate = DateFormat('dd MMM yyyy hh:mm a').format(date);
          return ListTile(
            isThreeLine: true,
            subtitle: Text(
              'address: ${data['address']}',
              style: TextStyle(color: Colors.black),
            ),
            title: Text(
              'Aadhar Number: ${data['aadharNumber']}',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Text(
              'time: $formattedDate',
              style: TextStyle(color: Colors.black),
            ),
          );
        },
      ),
    );
  }
//   late Stream<QuerySnapshot<Map<String, dynamic>>> _stream;

//   @override
//   void initState() {
//     super.initState();

//     // Get the stream of location history data based on the postal code
//     _stream = FirebaseFirestore.instance
//         .collection('location_history')
//         .where('postalCode', isEqualTo: '562157')
//         .orderBy('time', descending: true)
//         .snapshots();
//     displayUniqueData();
//   }

//   Future<void> displayUniqueData() async {
//     // Get a reference to the collection
//     CollectionReference<Map<String, dynamic>> collection =
//         FirebaseFirestore.instance.collection('location_history');

//     // Create a set to keep track of unique aadhar numbers
//     Set<String> uniqueAadharNumbers = {};

//     // Query the collection for all documents
//     QuerySnapshot<Map<String, dynamic>> snapshot =
//         await collection.orderBy('time', descending: true).get();

//     // Iterate over the documents and display only the unique ones
//     for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
//         in snapshot.docs) {
//       String aadharNumber = documentSnapshot.data()['aadharNumber'];
//       if (!uniqueAadharNumbers.contains(aadharNumber)) {
//         uniqueAadharNumbers.add(aadharNumber);
//         print(documentSnapshot.data());
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Childrens in your location'),
//       ),
//       body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//         stream: _stream,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final documents = snapshot.data!.docs;

//             if (documents.isNotEmpty) {
//               // Build a list of location history data cards

//               final cards = documents
//                   .map((doc) => LocationHistoryCard(data: doc.data()))
//                   .toList();

//               return ListView(children: cards);
//             } else {
//               // No data found for the postal code
//               return const Center(
//                 child: Text('No location history data found'),
//               );
//             }
//           } else if (snapshot.hasError) {
//             // Error occurred while retrieving data
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             // Data is still loading
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class LocationHistoryCard extends StatelessWidget {
//   final Map<String, dynamic> data;

//   const LocationHistoryCard({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     //Map<String, dynamic> latestRecords = {};
//     // for (Map<String, dynamic> record in data.values) {
//     //   String aadharNumber = record['aadharNumber'];

//     //   // Check if the Aadhar number already exists in the map
//     //   if (latestRecords.containsKey(aadharNumber)) {
//     //     // Compare the timestamps of the existing record and the current record
//     //     DateTime existingTime = latestRecords[aadharNumber]['time'].toDate();
//     //     DateTime currentTime = record['time'].toDate();
//     //     if (currentTime.isAfter(existingTime)) {
//     //       // Replace the existing record with the current record if the current record is newer
//     //       latestRecords[aadharNumber] = record;
//     //     }
//     //   } else {
//     //     // Add the record to the map if the Aadhar number doesn't already exist
//     //     latestRecords[aadharNumber] = record;
//     //   }
//     // }

//     // final time = DateFormat('dd MMM yyyy, hh:mm a')
//     //     .format(latestRecords['time'].toDate());

//     return Card(
//       elevation: 4.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ListTile(
//             leading: const Icon(Icons.location_on),
//             //title: Text(latestRecords['address']),

//             /// subtitle: Text(time),
//           ),
//           const Divider(),
//           ListTile(
//             leading: const Icon(Icons.person),
//             // title: Text(latestRecords['aadharNumber']),
//             // subtitle: Text('Condition: ${latestRecords['condition']}'),
//           ),
//         ],
//       ),
//     );
//   }
}
