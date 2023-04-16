import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../HomeScreen/home_screen.dart';

class OtpPage extends StatefulWidget {
  final String verificationId;
  const OtpPage({super.key, required this.verificationId});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otp = TextEditingController();
  bool showLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.orange[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 45,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Enter the OTP",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                //height: 90,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    autofocus: false,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                    keyboardType: TextInputType.number,
                    cursorColor: Theme.of(context).colorScheme.primary,
                    textInputAction: TextInputAction.done,
                    controller: otp,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Enter OTP",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 0.2,
                          color: Color.fromRGBO(230, 154, 141, 1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(235, 165, 54, 10), width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary,
                  child: MaterialButton(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        showLoading = true;
                      });
                      verifyCode();
                    },
                    child: showLoading
                        ? const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Submit",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp.text.toString());
    try {
      await _auth.signInWithCredential(credential).then((value) {
        print("Logged in successfully");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ),
        );
      });

      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(235, 165, 54, 10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Text('Login Successful',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            ],
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(235, 165, 54, 10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text('invalid-verification-code',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2),
                ),
              ],
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      setState(() {
        showLoading = false;
      });
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(235, 165, 54, 10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                    'The sms code has expired or you entered a wrong code. Please try again.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            ],
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

class SignupOtp extends StatefulWidget {
  final signUpVerificationID;
  final phoneNumber;
  final String userName;
  final String email;
  final String dob;
  final String gender;
  final String aadharNumber;
  final String address;

  const SignupOtp(
      {Key? key,
      required this.signUpVerificationID,
      required this.phoneNumber,
      required this.userName,
      required this.email,
      required this.dob,
      required this.gender,
      required this.aadharNumber,
      required this.address})
      : super(key: key);

  @override
  State<SignupOtp> createState() => _SignupOtpState();
}

class _SignupOtpState extends State<SignupOtp> {
  TextEditingController otp = TextEditingController();
  bool showLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //final String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 45,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Enter the OTP",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                autofocus: false,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
                keyboardType: TextInputType.number,
                cursorColor: Theme.of(context).colorScheme.primary,
                textInputAction: TextInputAction.done,
                controller: otp,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "Enter OTP",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 0.2,
                      color: Color.fromRGBO(230, 154, 141, 1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(235, 165, 54, 10), width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary,
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      showLoading = true;
                    });
                    verifyCode();
                  },
                  child: showLoading
                      ? const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Submit",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void verifyCode() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final phoneNumber = widget.phoneNumber;
    final userName = widget.userName;
    final email = widget.email;
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.signUpVerificationID,
        smsCode: otp.text.toString());
    try {
      // final id =
      // await FirebaseFirestore.instance.collection('users').doc(uid).get();
      // print(id);
      await _auth.signInWithCredential(credential).then((value) async {
        print("Logged in successfully");
        final uid = FirebaseAuth.instance.currentUser!.uid;
        print(uid);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser!.uid)
            .set({
          'phoneNumber': phoneNumber,
          'userName': userName,
          'email': email,
          'time': DateTime.now(),
          'image': "",
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MalnutritionChecker(),
          ),
        );
      });
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(235, 165, 54, 10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Text('Login Successful',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            ],
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      setState(() {
        showLoading = false;
      });
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(235, 165, 54, 10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'The sms code has expired or you entered a wrong code. Please try again.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2),
            ],
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
