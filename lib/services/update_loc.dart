import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateLocation extends StatefulWidget {
  const UpdateLocation({super.key});

  @override
  State<UpdateLocation> createState() => _UpdateLocationState();
}

class _UpdateLocationState extends State<UpdateLocation> {
  final TextEditingController _aadharNumberController = TextEditingController();
  String? aadharNumber;

  Future<void> _searchAadhar() async {
    FocusScope.of(context).unfocus();
    final String aadharNumberCo = _aadharNumberController.text.trim();

    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('children_details');
    Query query = collectionReference
        .where('aadharNumber', isEqualTo: aadharNumberCo)
        .limit(1);
    QuerySnapshot querySnapshot = await query.get();
    final docData = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (docData.isNotEmpty) {
      print("found");
      setState(() {
        aadharNumber = aadharNumberCo;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Found')));
      });
    } else {
      print("not found");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aadhar number not found')));
      setState(() {
        aadharNumber = null;
      });
    }

    // await FirebaseFirestore.instance
    //     .collection('children_details')
    //     .where('aadharNumber', isEqualTo: aadharNumberCo)
    //     .get()
    //     .then((event) {
    //   if (event.docs.isNotEmpty) {
    //     Map<String, dynamic> documentData =
    //         event.docs.single.data()[1]['aadharNumber'];
    //     print(documentData); //if it is a single document
    //   }
    // }).catchError((e) => print("error fetching data: $e"));
  }

  CollectionReference user =
      FirebaseFirestore.instance.collection('children_details');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Aadhaar'),
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
                labelText: 'Aadhaar Number',
                hintText: 'Aadhaar Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();
                final String aadharNumberCo =
                    _aadharNumberController.text.trim();

                final CollectionReference collectionReference =
                    FirebaseFirestore.instance.collection('children_details');
                Query query = collectionReference
                    .where('aadharNumber', isEqualTo: aadharNumberCo)
                    .limit(1);
                QuerySnapshot querySnapshot = await query.get();
                final docData =
                    querySnapshot.docs.map((doc) => doc.data()).toList();

                if (docData.isNotEmpty) {
                  print("found");
                  setState(() {
                    aadharNumber = aadharNumberCo;
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Found')));
                  });
                } else {
                  print("not found");
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Aadhar number not found')));
                  setState(() {
                    aadharNumber = null;
                  });
                }
                // ignore: use_build_context_synchronously
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        title: Text('Result'),
                        content: Text('Result '),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Go Back'))
                        ],
                      );
                    });

                // await FirebaseFirestore.instance
                //     .collection('children_details')
                //     .where('aadharNumber', isEqualTo: aadharNumberCo)
                //     .get()
                //     .then((event) {
                //   if (event.docs.isNotEmpty) {
                //     Map<String, dynamic> documentData =
                //         event.docs.single.data()[1]['aadharNumber'];
                //     print(documentData); //if it is a single document
                //   }
                // }).catchError((e) => print("error fetching data: $e"));
              },
              child: Text('Search'),
            ),
            SizedBox(height: 16.0),
            if (aadharNumber == null)
              Text('No data found for the given Aadhar number.')
            else
              StreamBuilder<Object>(
                stream: user
                    .where('aadharNumber', isEqualTo: '8988898898')
                    .snapshots(),
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
                  var docs = snapshot.data;

                  return Text("docs");
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
