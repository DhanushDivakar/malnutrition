import 'package:flutter/material.dart';
import 'package:malnutrition/auth/login.dart';
import 'package:malnutrition/services/data_location.dart';

import 'package:malnutrition/services/getlocation.dart';
import 'package:malnutrition/services/loc_history.dart';
import 'package:malnutrition/services/malnutrition_checker.dart';
import 'package:malnutrition/services/update_loc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Box> boxes = [
    Box(
      color: Color.fromARGB(240, 165, 224, 255),
      icon: Icons.health_and_safety_rounded,
      text: 'Box 1',
      onTap: () {
        print('Box 1 tapped!');
      },
    ),
    Box(
      color: Color.fromARGB(255, 255, 179, 158),
      icon: Icons.add_home_work,
      text: 'Box 2',
      onTap: () {
        print('Box 2 tapped!');
      },
    ),
    Box(
      color: Color.fromARGB(251, 251, 226, 127),
      icon: Icons.update,
      text: 'Box 3',
      onTap: () {
        print('Box 3 tapped!');
      },
    ),
    Box(
      color: const Color.fromARGB(255, 232, 193, 255),
      icon: Icons.grid_view,
      text: 'Box 4',
      onTap: () {
        print('Box 4 tapped!');
      },
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Malnutrition Monitor'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: boxes.map((box) => buildBoxCard(box)).toList(),
      ),
      // SingleChildScrollView(
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         ElevatedButton(
      //           onPressed: () {
      //             Navigator.push(context, MaterialPageRoute(builder: (context) {
      //               return const AddChild();
      //             }));
      //           },
      //           child: const Text("Add child"),
      //         ),
      //         ElevatedButton(
      //           onPressed: () {
      //             Navigator.push(context, MaterialPageRoute(builder: (context) {
      //               return const UpdateLocation();
      //             }));
      //           },
      //           child: const Text("Update Location"),
      //         ),
      //         ElevatedButton(
      //           onPressed: () {
      //             Navigator.push(context, MaterialPageRoute(builder: (context) {
      //               return const LocHistory();
      //             }));
      //           },
      //           child: const Text("See history"),
      //         ),
      //         ElevatedButton(
      //           onPressed: () {
      //             Navigator.push(context, MaterialPageRoute(builder: (context) {
      //               return const DataBasedOnLocation();
      //             }));
      //           },
      //           child: const Text("get all child in your area"),
      //         ),
      //         ElevatedButton(
      //           onPressed: () async {
      //             SharedPreferences pref =
      //                 await SharedPreferences.getInstance();
      //             pref.remove("phoneNumber");
      //             // ignore: use_build_context_synchronously
      //             Navigator.push(context, MaterialPageRoute(builder: (context) {
      //               return const LoginPage();
      //             }));
      //           },
      //           child: const Text("Logout"),
      //         ),
      //         ElevatedButton(
      //           onPressed: () async {
      //             Navigator.push(context, MaterialPageRoute(builder: (context) {
      //               return const MalnutritionChecker();
      //             }));
      //           },
      //           child: const Text("Malnutrition Checker"),
      //         ),

      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

Widget buildBoxCard(Box box) {
  return GestureDetector(
    onTap: box.onTap,
    child: Container(
      //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Card(
        color: box.color,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              box.icon,
              size: 50,
              color: Color.fromARGB(255, 30, 30, 30),
            ),
            const SizedBox(height: 10),
            Text(
              box.text,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    ),
  );
}

class Box {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color color;

  Box(
      {required this.icon,
      required this.text,
      required this.onTap,
      required this.color});
}
