import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UpdateLocation extends StatefulWidget {
  const UpdateLocation({super.key});

  @override
  State<UpdateLocation> createState() => _UpdateLocationState();
}

class _UpdateLocationState extends State<UpdateLocation> {
  final TextEditingController _aadharNumberController = TextEditingController();
  String? aadharNumber;

  Future<void> _searchAadhar() async {
    final String aadharNumberCo = _aadharNumberController.text.trim();

    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('children_details');
    Query query =
        collectionReference.where('aadharNumber', isEqualTo: aadharNumberCo);
    QuerySnapshot querySnapshot = await query.get();
    final docData = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (docData.isNotEmpty) {
      print("found");
      setState(() {
        aadharNumber = querySnapshot.docs.toString();
      });
    } else {
      print("not found");
      setState(() {
        aadharNumber = null;
      });
    }
    print(aadharNumberCo);

    // print(aadharNumber![0].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Aadhar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              maxLength: 12,
              controller: _aadharNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Aadhar Number',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _searchAadhar,
              child: Text('Search'),
            ),
            SizedBox(height: 16.0),
            if (aadharNumber == null)
              Text('No data found for the given Aadhar number.')
            else
              FutureBuilder<Object>(
                future: FirebaseFirestore.instance
                    .collection('children_details')
                    .doc()
                    .get(),
                builder: (context, snapshot) {
                  //   CollectionReference collectionReference =  FirebaseFirestore.instance
                  //     .collection('children_details')
                  //     .doc()
                  //     .get();
                  //    Query query =
                  //     collectionReference.where('aadharNumber', isEqualTo: aadharNumberCo);
                  // QuerySnapshot querySnapshot = await query.get(),
                  if (snapshot.hasError) {
                    return Text('Error = ${snapshot.error}');
                  }
                  return Text("");
                },
              )
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text('Name: ${aadharNumber![0].toString()}'),
            //         ],
            //       ),
          ],
        ),
      ),
    );
  }
}
