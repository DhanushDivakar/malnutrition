import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class LocHistory extends StatefulWidget {
  const LocHistory({super.key});

  @override
  State<LocHistory> createState() => _LocHistoryState();
}

class _LocHistoryState extends State<LocHistory> {
  final TextEditingController _aadharNumberController = TextEditingController();
  String? _aadharNumber;
  Map<String, dynamic>? _childData;
  bool _isLoading = false;

  List<DocumentSnapshot> _docs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final collectionReference =
        FirebaseFirestore.instance.collection('location_history');
    final query = collectionReference
        .where('aadharNumber', isEqualTo: _aadharNumber)
        .orderBy('time', descending: true);
    final querySnapshot = await query.get();
    setState(() {
      _docs = querySnapshot.docs;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location History'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: TextFormField(
              textInputAction: TextInputAction.search,
              maxLength: 12,
              controller: _aadharNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Enter Aadhar Number',
                border: OutlineInputBorder(),
              ),
              onFieldSubmitted: (value) async {
                setState(() {
                  _isLoading = true;
                  _aadharNumber = _aadharNumberController.text.trim();
                  _childData = null;
                });

                final collectionReference =
                    FirebaseFirestore.instance.collection('children_details');
                final querySnapshot = await collectionReference
                    .where('aadharNumber', isEqualTo: _aadharNumber)
                    .get();
                final docData =
                    querySnapshot.docs.map((doc) => doc.data()).toList();

                setState(() {
                  _isLoading = false;
                  if (docData.isNotEmpty) {
                    _childData = docData.first;
                  }
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty || value.length != 12) {
                  return 'Please enter a valid 12 digit Aadhar number';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16.0),
          _isLoading
              ? const CircularProgressIndicator()
              : _childData == null
                  ? const Text('No results found')
                  : Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _childData!['childName'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        _childData!['gender'],
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Guardian Name',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        _childData!['guardianName'],
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Aadhar Number',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    _childData!['aadharNumber'],
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('location_history')
                .where('aadharNumber', isEqualTo: _aadharNumber)
                .get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.data!.docs.isEmpty) {
                return const Text('No data found.');
              }

              return _aadharNumber == null
                  ? Container()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> data = snapshot.data!.docs[index]
                              .data() as Map<String, dynamic>;
                          DateTime date = DateTime.fromMillisecondsSinceEpoch(
                              data['time'].seconds * 1000);
                          String formattedDate =
                              DateFormat('dd MMM yyyy hh:mm a').format(date);

                          return Card(
                            child: ListTile(
                              title: Text(data['address']),
                              trailing: Text('Time: $formattedDate'),
                              subtitle: Text('Condition: ${data['condition']}'),
                            ),
                          );
                        },
                      ),
                    );
            },
          )
        ],
      ),
    );
  }
}
