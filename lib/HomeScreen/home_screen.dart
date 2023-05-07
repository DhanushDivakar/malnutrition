import 'package:flutter/material.dart';
import 'package:malnutrition/services/getlocation.dart';
import 'package:malnutrition/services/loc_history.dart';
import 'package:malnutrition/services/malnutrition_checker.dart';
import 'package:malnutrition/services/update_loc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Box> boxes = [
    Box(
      color: const Color.fromARGB(240, 165, 224, 255),
      icon: Icons.health_and_safety_rounded,
      text: 'Check',
      page: const MalnutritionChecker(),
    ),
    Box(
      color: const Color.fromARGB(255, 255, 179, 158),
      icon: Icons.add_home_work,
      text: 'Add',
      page: const AddChild(),
    ),
    Box(
      color: const Color.fromARGB(251, 251, 226, 127),
      icon: Icons.update,
      text: 'Update',
      page: const UpdateLocation(),
    ),
    Box(
      color: const Color.fromARGB(255, 232, 193, 255),
      icon: Icons.grid_view,
      text: 'View history',
      page: const LocHistory(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: const Text('Malnutrition Monitor'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: boxes.map((box) => buildBoxCard(context, box)).toList(),
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

Widget buildBoxCard(BuildContext context, Box box) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return box.page;
          },
        ),
      );
    },
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
              size: 70,
              color: const Color.fromARGB(255, 30, 30, 30),
            ),
            const SizedBox(height: 10),
            Text(
              box.text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
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

  final Color color;
  final Widget page;

  Box(
      {required this.icon,
      required this.text,
      required this.color,
      required this.page});
}
