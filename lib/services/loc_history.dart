import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  Future<void> _searchAadharNumber() async {
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
    final docData = querySnapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      _isLoading = false;
      if (docData.isNotEmpty) {
        _childData = docData.first;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location History'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
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
            SizedBox(height: 16.0),
            _isLoading
                ? CircularProgressIndicator()
                : _childData == null
                    ? Text('No results found')
                    : Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text(_childData!['childName']),
                            ),
                            ListTile(
                              //leading: Icon(Icons.venus_mars),
                              title: Text(_childData!['gender']),
                            ),
                            ListTile(
                              leading: Icon(Icons.credit_card),
                              title: Text(_childData!['aadharNumber']),
                            ),
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text(_childData!['guardianName']),
                            ),
                            ListTile(
                              leading: Icon(Icons.location_on),
                              title: Text(_childData!['address']),
                            ),
                            ListTile(
                              leading: Icon(Icons.medical_services),
                              title: Text(_childData!['condition']),
                            ),
                            ListTile(
                              leading: Icon(Icons.access_time),
                              title: Text(_childData!['time'].toString()),
                            ),
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
