import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataBasedOnLocation extends StatefulWidget {
  const DataBasedOnLocation({super.key});

  @override
  State<DataBasedOnLocation> createState() => _DataBasedOnLocationState();
}

class _DataBasedOnLocationState extends State<DataBasedOnLocation> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _stream;

  @override
  void initState() {
    super.initState();

    // Get the stream of location history data based on the postal code
    _stream = FirebaseFirestore.instance
        .collection('location_history')
        .where('postalCode', isEqualTo: '562157')
        .orderBy('time', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Childrens in your location'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final documents = snapshot.data!.docs;

            if (documents.isNotEmpty) {
              // Build a list of location history data cards

              final cards = documents
                  .map((doc) => LocationHistoryCard(data: doc.data()))
                  .toList();

              return ListView(children: cards);
            } else {
              // No data found for the postal code
              return const Center(
                child: Text('No location history data found'),
              );
            }
          } else if (snapshot.hasError) {
            // Error occurred while retrieving data
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Data is still loading
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class LocationHistoryCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const LocationHistoryCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> latestRecords = {};
    // for (Map<String, dynamic> record in data.values) {
    //   String aadharNumber = record['aadharNumber'];

    //   // Check if the Aadhar number already exists in the map
    //   if (latestRecords.containsKey(aadharNumber)) {
    //     // Compare the timestamps of the existing record and the current record
    //     DateTime existingTime = latestRecords[aadharNumber]['time'].toDate();
    //     DateTime currentTime = record['time'].toDate();
    //     if (currentTime.isAfter(existingTime)) {
    //       // Replace the existing record with the current record if the current record is newer
    //       latestRecords[aadharNumber] = record;
    //     }
    //   } else {
    //     // Add the record to the map if the Aadhar number doesn't already exist
    //     latestRecords[aadharNumber] = record;
    //   }
    // }

    // final time = DateFormat('dd MMM yyyy, hh:mm a')
    //     .format(latestRecords['time'].toDate());

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.location_on),
            title: Text(latestRecords['address']),

            /// subtitle: Text(time),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(latestRecords['aadharNumber']),
            subtitle: Text('Condition: ${latestRecords['condition']}'),
          ),
        ],
      ),
    );
  }
}
