import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:malnutrition/auth/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phonenum = TextEditingController();
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  bool showLoading = false;
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
          // leading: IconButton(
          //   icon: Icon(
          //     Icons.chevron_left_rounded,
          //     color: Theme.of(context).colorScheme.primary,
          //     size: 45,
          //   ),
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          // ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.3,
                width: width * 0.3,
                child: Image.network(
                    'https://www.pngitem.com/pimgs/m/191-1914207_mother-and-baby-logo-png-transparent-png.png'),
              ),
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
                  //key: formKey,
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
                    // controller: phonenum,
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
                                      child: Image.network(
                                          'https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/800px-Flag_of_India.svg.png')),
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
                      final isValid = formKey.currentState!.validate();
                      if (isValid) {
                    setState(() {
                      showLoading = true;
                    });
                    CollectionReference collectionRef =
                        FirebaseFirestore.instance.collection('users');
                         QuerySnapshot querySnapshot = await collectionRef
                        .where('phoneNumber', isEqualTo: phonenum.text)
                        .get();
                         final allData =
                        querySnapshot.docs.map((doc) => doc.data()).toList();
                      }
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
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
