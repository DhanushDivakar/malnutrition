import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:malnutrition/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String? phNumber;
  @override
  void initState() {
    _fetchData();

    super.initState();
  }

  bool isLoading = false;
  List<DocumentSnapshot> userDocuments = [];

  Future<void> _fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var phoneNumber = prefs.getString("phoneNumber");
    final collectionReference = FirebaseFirestore.instance.collection('auth');
    final query = collectionReference.where('phoneNumber', isEqualTo: phNumber);
    final querySnapshot = await query.get();
    setState(() {
      phNumber = phoneNumber;
      print(phoneNumber);
      isLoading = false;
      userDocuments = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: userDocuments.length,
              itemBuilder: (context, index) {
                final userData =
                    userDocuments[index].data() as Map<String, dynamic>;
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Name: ${userData['name']}',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text('Phone Number: ${userData['phoneNumber']}'),
                      const SizedBox(height: 8.0),
                      Text('Aadhaar Number: ${userData['aadhaarNumber']}'),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.remove("phoneNumber");
                          // ignore: use_build_context_synchronously
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const LoginPage();
                          }));
                        },
                        child: const Text("Logout"),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
