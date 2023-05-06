import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:malnutrition/HomeScreen/home_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phonenum = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final FocusNode pinFocusNode = FocusNode();
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  String? pinCode;

  bool showLoading = false;

  @override
  void dispose() {
    pinController.dispose();
    pinFocusNode.dispose();
    super.dispose();
  }

  Future<void> authenticateUser(String phoneNumber, String pin) async {
    try {
      setState(() {
        showLoading = true;
      });
      // Get a reference to the 'auth' collection
      CollectionReference<Map<String, dynamic>> authCollection =
          FirebaseFirestore.instance.collection('auth');

      // Query the collection for a document with the entered phone number
      QuerySnapshot<Map<String, dynamic>> snapshot = await authCollection
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      // Check if a document with the entered phone number exists
      if (snapshot.docs.isNotEmpty) {
        // Get the document data
        Map<String, dynamic> authData = snapshot.docs[0].data();

        // Check if the entered PIN matches the PIN in the document
        if (authData['pin'] == pin) {
          print("Correct pin");
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("phoneNumber", phoneNumber);

          setState(() {
            showLoading = false;
          });
          // Authentication successful
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
        } else {
          print("wrong pin");
          setState(() {
            showLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect pin')),
          );
        }
      }
    } catch (e) {
      print('Error authenticating user: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Something went wrong, try after some time')),
      );
    }

    // Authentication failed
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const focusedBorderColor = Colors.orange;
    const fillColor = Color.fromARGB(0, 198, 133, 77);
    const borderColor = Colors.black;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      margin: const EdgeInsets.all(10),
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
    );
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
              Form(
                // key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Directionality(
                      // Specify direction if desired
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        controller: pinController,
                        focusNode: pinFocusNode,

                        defaultPinTheme: defaultPinTheme,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter 4 digit pin";
                          }
                          return null;
                        },
                        // onClipboardFound: (value) {
                        //   debugPrint('onClipboardFound: $value');
                        //   pinController.setText(value);
                        // },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          pinCode = pin;
                          debugPrint('onCompleted: $pin');
                        },

                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: focusedBorderColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: Colors.redAccent),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: showLoading
                    ? const CircularProgressIndicator()
                    : Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primary,
                        child: MaterialButton(
                          //padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            print(pinCode);
                            if (pinCode != null) {
                              authenticateUser(phonenum.text, pinCode!);
                            }
                          },
                          child: Text(
                            "Login",
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
