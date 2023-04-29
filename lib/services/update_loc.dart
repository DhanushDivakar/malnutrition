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
  String? _currentAddress;

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

  @override
  Widget build(BuildContext context) {
    final TextEditingController descriptionController = TextEditingController();
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
                    FirebaseFirestore.instance.collection('location_history');
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
                  final QuerySnapshot<Map<String, dynamic>> childSnapshot =
                      await getChildData(aadharNumber!);
                  final childData = childSnapshot.docs[0].data();
                  // ignore: use_build_context_synchronously
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 4,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            childData['childName'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            childData['gender'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Aadhaar Number: ${childData['aadharNumber']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Guardian Name: ${childData['guardianName']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Previous Location: ${childData['address']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    labelText: 'Condition',
                                    border: OutlineInputBorder(),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  value: _selectedCondition,
                                  enableFeedback: true,
                                  items: _condition
                                      .map((gender) => DropdownMenuItem<String>(
                                            value: gender,
                                            child: Text(gender),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedCondition = value;
                                    });
                                    print(_selectedCondition);
                                  },
                                  isExpanded: true,
                                ),
                                SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        //                             FirebaseFirestore.instance
                                        //     .collection('location_history')
                                        //     .doc(_aadharNumber)
                                        //     .set({
                                        //   'childName': _childName,
                                        //   'gender': _selectedGender,
                                        //   'aadharNumber': _aadharNumber,
                                        //   'guardianName': _guardianName,
                                        //   'address': _currentAddress,
                                        //   'condition': _selectedCondition,
                                        //   'time': DateTime.now(),
                                        // }).catchError((e) {
                                        //   print('failed to add into loc history');
                                        // }).then((value) {
                                        //   if (mounted) {
                                        //     setState(() {
                                        //       isLoading = false;
                                        //     });
                                        //   }
                                        // });
                                      },
                                      child: const Text('Update')),
                                ),
                                // TextFormField(
                                //   controller: descriptionController,
                                //   decoration: InputDecoration(
                                //     border: OutlineInputBorder(),
                                //     hintText: 'Enter description',
                                //   ),
                                // ),
                              ],
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
