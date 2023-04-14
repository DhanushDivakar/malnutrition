import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:malnutrition/auth/otp.dart';

class RegisterPage extends StatefulWidget {
  final String phoneNumber;
  const RegisterPage({super.key, required this.phoneNumber});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phonenumController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController aadharController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
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
              size: height * 0.05,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Sign In/ Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: height * 0.035,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  //key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length != 10) {
                            return "Enter correct number";
                          } else {
                            return null;
                          }
                        },

                        autofocus: false,
                        //controller: ,
                        style: TextStyle(
                            fontSize: height * 0.02,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        //keyboardType: TextInputType.number,
                        cursorColor: Theme.of(context).colorScheme.primary,
                        textInputAction: TextInputAction.done,
                        controller: nameController,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Name",
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
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length != 10) {
                            return "Enter correct number";
                          } else {
                            return null;
                          }
                        },
                        autofocus: false,
                        style: TextStyle(
                            fontSize: height * 0.02,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        keyboardType: TextInputType.number,
                        cursorColor: Theme.of(context).colorScheme.primary,
                        textInputAction: TextInputAction.done,
                        controller: phonenumController,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Phone number",
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
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length != 10) {
                            return "Enter correct number";
                          } else {
                            return null;
                          }
                        },
                        autofocus: false,
                        style: TextStyle(
                            fontSize: height * 0.02,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        keyboardType: TextInputType.number,
                        cursorColor: Theme.of(context).colorScheme.primary,
                        textInputAction: TextInputAction.done,
                        controller: dobController,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Date of Birth",
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
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length != 10) {
                            return "Enter correct number";
                          } else {
                            return null;
                          }
                        },
                        autofocus: false,
                        style: TextStyle(
                            fontSize: height * 0.02,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        cursorColor: Theme.of(context).colorScheme.primary,
                        textInputAction: TextInputAction.done,
                        controller: genderController,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Gender",
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
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length != 10) {
                            return "Enter correct number";
                          } else {
                            return null;
                          }
                        },
                        autofocus: false,
                        style: TextStyle(
                            fontSize: height * 0.02,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Theme.of(context).colorScheme.primary,
                        textInputAction: TextInputAction.done,
                        controller: emailController,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Email",
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
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length != 10) {
                            return "Enter correct number";
                          } else {
                            return null;
                          }
                        },
                        autofocus: false,
                        style: TextStyle(
                            fontSize: height * 0.02,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        keyboardType: TextInputType.number,
                        cursorColor: Theme.of(context).colorScheme.primary,
                        textInputAction: TextInputAction.done,
                        controller: aadharController,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Aadhaar Number",
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
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length != 10) {
                            return "Enter correct number";
                          } else {
                            return null;
                          }
                        },
                        autofocus: false,
                        style: TextStyle(
                            fontSize: height * 0.02,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        maxLines: 3,
                        cursorColor: Theme.of(context).colorScheme.primary,
                        textInputAction: TextInputAction.done,
                        controller: addressController,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Address",
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
                    ],
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
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      final isValid = _formKey.currentState!.validate();
                      if (isValid) {
                        setState(() {
                          showLoading = true;
                        });
                        try {
                          await auth.verifyPhoneNumber(
                              phoneNumber: '+91$phonenumController',
                              verificationCompleted: (_) {
                                setState(() {
                                  showLoading = false;
                                });
                              },
                              verificationFailed: (e) {
                                final snackBar = SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  content: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          138, 80, 196, 60),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            e.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                setState(() {
                                  showLoading = false;
                                });
                                print(e.message);
                              },
                              codeSent: (String SignUpVerificationId,
                                  int? token) async {
                                print(SignUpVerificationId);
                                print("Hiii");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupOtp(
                                      signUpVerificationID:
                                          SignUpVerificationId,
                                      phoneNumber: phonenumController,
                                      userName: nameController.text,
                                      email: emailController.text,
                                      dob: dobController.text,
                                      aadharNumber: aadharController.text,
                                      address: addressController.text,
                                      gender: genderController.text,
                                    ),
                                  ),
                                );
                                final uid =
                                    FirebaseAuth.instance.currentUser!.uid;
                                print(uid);

                                setState(() {
                                  showLoading = false;
                                });
                              },
                              codeAutoRetrievalTimeout: (e) {
                                final snackBar = SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  content: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          138, 80, 196, 60),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            e,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                // ScaffoldMessenger.of(context)
                                //     .showSnackBar(snackBar);
                                setState(() {
                                  showLoading = false;
                                });
                                print(e);
                              });
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: showLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 17,
                            ),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
