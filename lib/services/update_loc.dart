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
              onSubmitted: (String value) async {
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
                  });
                } else {
                  print("not found");

                  setState(() {
                    aadharNumber = null;
                  });
                }
                if (docData.isNotEmpty) {
                  // ignore: use_build_context_synchronously
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: const Text('Search'),
                          content: Text(
                              'Aadhaar number ${_aadharNumberController.text} found'),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('yes'))
                          ],
                        );
                      });
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
              decoration: InputDecoration(
                labelText: 'Aadhaar Number',
                hintText: 'Aadhaar Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: () async {
            //     FocusScope.of(context).unfocus();
            //     final String aadharNumberCo =
            //         _aadharNumberController.text.trim();

            //     final CollectionReference collectionReference =
            //         FirebaseFirestore.instance.collection('children_details');
            //     Query query = collectionReference
            //         .where('aadharNumber', isEqualTo: aadharNumberCo)
            //         .limit(1);
            //     QuerySnapshot querySnapshot = await query.get();
            //     final docData =
            //         querySnapshot.docs.map((doc) => doc.data()).toList();

            //     if (docData.isNotEmpty) {
            //       print("found");
            //       setState(() {
            //         aadharNumber = aadharNumberCo;
            //       });
            //     } else {
            //       print("not found");

            //       setState(() {
            //         aadharNumber = null;
            //       });
            //     }
            //     if (docData.isNotEmpty) {
            //       // ignore: use_build_context_synchronously
            //       showDialog(
            //           context: context,
            //           builder: (BuildContext context) {
            //             return AlertDialog(
            //               shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(10)),
            //               title: const Text('Search'),
            //               content: Text(
            //                   'Aadhaar number ${_aadharNumberController.text} found'),
            //               actions: [
            //                 ElevatedButton(
            //                     onPressed: () {
            //                       Navigator.pop(context);
            //                     },
            //                     child: Text('yes'))
            //               ],
            //             );
            //           });
            //     } else {
            //       // ignore: use_build_context_synchronously
            //       showDialog(
            //           context: context,
            //           builder: (BuildContext context) {
            //             return AlertDialog(
            //               shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(10)),
            //               title: const Text('Search'),
            //               content: Text(
            //                   'Aadhaar number ${_aadharNumberController.text} not found, please register'),
            //               actions: [
            //                 ElevatedButton(
            //                   onPressed: () {
            //                     Navigator.pop(context);
            //                   },
            //                   child: const Text('Go Back'),
            //                 )
            //               ],
            //             );
            //           });
            //     }
            //   },
            //   child: const Text('Search'),
            //   // child: Text('Search'),
            // ),
            const SizedBox(height: 16.0),

            // StreamBuilder(
            //   stream: user
            //       .where('aadharNumber',
            //           isEqualTo: _aadharNumberController.text)
            //       .snapshots(),
            //   builder: (context, snapshot) {
            //     //   CollectionReference collectionReference =  FirebaseFirestore.instance
            //     //     .collection('children_details')
            //     //     .doc()
            //     //     .get();
            //     //    Query query =
            //     //     collectionReference.where('aadharNumber', isEqualTo: aadharNumberCo);
            //     // QuerySnapshot querySnapshot = await query.get(),
            //     if (snapshot.hasError) {
            //       return Text('Error = ${snapshot.error}');
            //     }
            //     if (snapshot.hasData) {
            //       //final data = snapshot.data as DocumentSnapshot;
            //       Map<String, dynamic> items =
            //           snapshot.data!.docs as Map<String, dynamic>;

            //       //Map<String, dynamic> documentData = snapshot.data! as Map<String, dynamic>;
            //       final a = items['aadharNumber'];
            //       print(a);
            //     }

            //     return Text("docs");
            //   },
            // )
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
