import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;

import 'package:malnutrition/services/getlocation.dart';
import 'package:malnutrition/services/malnutrition_checker.dart';
import 'package:malnutrition/services/update_loc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
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
            const Divider(),
            ListTile(
              title: const Text('Track'),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return const MalnutritionChecker();
                // }));
                // Do something when Option 2 is tapped
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AddChild();
                  }));
                },
                child: Text("Add child"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const UpdateLocation();
                  }));
                },
                child: const Text("Update Location"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
