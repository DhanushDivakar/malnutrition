import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:malnutrition/auth/otp.dart';
import 'package:malnutrition/auth/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phonenum = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  bool showLoading = false;

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

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
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: height * 0.3,
              //   width: width * 0.3,
              //   child: Image.network(
              //       'https://www.pngitem.com/pimgs/m/191-1914207_mother-and-baby-logo-png-transparent-png.png'),
              // ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Login in",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: height * 0.04,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: phonenum,
                    validator: (value) {
                      if (value!.isEmpty || value.length != 10) {
                        return "Enter correct number";
                      } else {
                        return null;
                      }
                    },
                    maxLength: 10,
                    autofocus: false,
                    style: TextStyle(
                        fontSize: width * 0.04,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    keyboardType: TextInputType.number,
                    cursorColor: Theme.of(context).colorScheme.primary,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Phone Number",
                      prefixIcon: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                        'assets/Flag_of_India.svg.webp'),
                                  ),
                                  const VerticalDivider(
                                    color: Colors.black26,
                                    thickness: 1,
                                  ),
                                  const Text(
                                    "(+91)",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 0.2,
                          color: Color.fromRGBO(230, 154, 141, 1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(20.0),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       PinPut(
              //         fieldsCount: 4,
              //         textStyle: TextStyle(fontSize: 20.0),
              //         eachFieldWidth: 60.0,
              //         eachFieldHeight: 60.0,
              //         onSubmit: (String pin) {
              //           // Handle PIN submission
              //           print('Entered PIN: $pin');
              //         },
              //         focusNode: _pinFocusNode,
              //         controller: _pinController,
              //         submittedFieldDecoration: BoxDecoration(
              //           color: Colors.green,
              //           borderRadius: BorderRadius.circular(10.0),
              //         ),
              //         selectedFieldDecoration: BoxDecoration(
              //           color: Colors.blue,
              //           borderRadius: BorderRadius.circular(10.0),
              //         ),
              //         followingFieldDecoration: BoxDecoration(
              //           color: Colors.grey,
              //           borderRadius: BorderRadius.circular(10.0),
              //         ),
              //       ),
              //       SizedBox(height: 20.0),

              //     ],
              //   ),
              // ),

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
                    controller: otpController,
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
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary,
                  child: MaterialButton(
                    //padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(
                            phoneNumber: phonenum.text,
                          ),
                        ),
                      );
                    },
                    child: showLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: height * 0.025,
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
}
