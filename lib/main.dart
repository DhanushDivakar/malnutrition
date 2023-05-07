import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:malnutrition/HomeScreen/bottombar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var phoneNumber = prefs.getString("phoneNumber");
  print(phoneNumber);

  runApp(
    phoneNumber == null ? const MyAApp() : const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 251, 64, 104),
          secondary: Colors.white,
        ),
      ),
      home: const MyNavigationBar(),
    );
  }
}

class MyAApp extends StatelessWidget {
  const MyAApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 251, 64, 104),
          secondary: Colors.white,
        ),
      ),
      home: const LoginPage(),
    );
  }
}
