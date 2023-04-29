import 'package:flutter/material.dart';

import 'package:malnutrition/services/getlocation.dart';
import 'package:malnutrition/services/malnutrition_checker.dart';
import 'package:malnutrition/services/update_loc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Malnutrition Monitor'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text('Menu'),
            ),
            ListTile(
              title: const Text('Malnutrition Checker'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const MalnutritionChecker();
                }));
              },
            ),
            // const Divider(),
            // ListTile(
            //   title: const Text('Track'),
            //   onTap: () {
            //     // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //     //   return const MalnutritionChecker();
            //     // }));
            //     // Do something when Option 2 is tapped
            //   },
            // ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AddChild();
                  }));
                },
                child: Text("Add child"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const UpdateLocation();
                  }));
                },
                child: const Text("Update Location"),
              ),
              //   ElevatedButton(
              //   onPressed: () {},
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 24.0,
              //       vertical: 16.0,
              //     ),
              //     child: Text(
              //       'Button 1',
              //       style: TextStyle(
              //         fontSize: 20.0,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.green,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(24.0),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       ElevatedButton(
      //         onPressed: () {
      //           // Handle button press
      //         },
      //         child: Text('Click me!'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
