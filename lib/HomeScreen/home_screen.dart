import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _muacController = TextEditingController();
  final TextEditingController _headCircumferenceController =
      TextEditingController();
  final TextEditingController _skinfoldThicknessController =
      TextEditingController();

  String malnutritionStatus = '';

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _muacController.dispose();
    _headCircumferenceController.dispose();
    _skinfoldThicknessController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: const Text('Malnutrition Chekcer'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Text(
                      'Age: ',
                      style: TextStyle(
                        fontSize: height * 0.025,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Text(
                      'Weight (Kg): ',
                      style: TextStyle(
                        fontSize: height * 0.025,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Text(
                      'Height (cm): ',
                      style: TextStyle(
                        fontSize: height * 0.025,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Text(
                      'MUAC (cm): ',
                      style: TextStyle(
                        fontSize: height * 0.025,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      controller: _muacController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(
              //       width: MediaQuery.of(context).size.width / 3,
              //       child: Text(
              //         'BMI: ',
              //         style: TextStyle(
              //           fontSize: height * 0.025,
              //         ),
              //       ),
              //     ),
              //     const SizedBox(width: 10),
              //     Flexible(
              //       child: TextField(
              //         controller: _bmiController,
              //         keyboardType: TextInputType.number,
              //         decoration: const InputDecoration(
              //           border: OutlineInputBorder(),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Text(
                      'head circumference (cm): ',
                      style: TextStyle(
                        fontSize: height * 0.025,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      controller: _headCircumferenceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Text(
                      'SkinFold thickness (mm): ',
                      style: TextStyle(
                        fontSize: height * 0.025,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      controller: _skinfoldThicknessController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: ElevatedButton(
                  onPressed: () {
                    // String status = checkMalnutritionStatus(
                    //     age: 10,
                    //     weight: 6,
                    //     height: 70,
                    //     muac: 12.5,
                    //     headCircumference: 45,
                    //     skinfoldThickness: 110);
                    // print('Malnutrition Status: $status');
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Calculate',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Result:  $malnutritionStatus ',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// String getChildMalnutritionStatus(double ageInMonths, double weight, double height, double muac, double headCircumference, double skinfoldThickness) {
//   // calculate z-scores for each measurement
//   double weightZScore = calculateWeightZScore(ageInMonths, weight, gender);
//   double heightZScore = calculateHeightZScore(ageInMonths, height, gender);
//   double muacZScore = calculateMUACZScore(ageInMonths, muac, gender);
//   double headCircumferenceZScore = calculateHeadCircumferenceZScore(ageInMonths, headCircumference, gender);
//   double skinfoldThicknessZScore = calculateSkinfoldThicknessZScore(ageInMonths, skinfoldThickness, gender);

//   // calculate composite z-score
//   double compositeZScore = weightZScore + heightZScore + muacZScore + headCircumferenceZScore + skinfoldThicknessZScore;

//   // determine nutritional status based on composite z-score
//   if (compositeZScore >= -1 && compositeZScore <= 1) {
//     return "Normal";
//   } else if (compositeZScore >= -2 && compositeZScore < -1) {
//     return "Moderately Malnourished";
//   } else if (compositeZScore < -2) {
//     return "Severely Malnourished";
//   }

//   return "N/A"; // return N/A if child is over 5 years old
// }

// double? calculateWeightZScore(double ageInMonths, double weight, String gender) {
//   // define L, M, and S values for weight-for-age by gender and age
//   double L, M, S;
  
//   if (gender == "male") {
//     if (ageInMonths >= 0 && ageInMonths < 24) {
//       L = -0.544;
//       M = 7.6256;
//       S = 0.1467;
//     } else if (ageInMonths >= 24 && ageInMonths < 60) {
//       L = -0.1544;
//       M = 13.4064;
//       S = 0.0903;
//     } else {
//       return null; // return null if child is over 5 years old
//     }
//   } else if (gender == "female") {
//     if (ageInMonths >= 0 && ageInMonths < 24) {
//       L = -0.611;
//       M = 7.2032;
//       S = 0.1468;
//     } else if (ageInMonths >= 24 && ageInMonths < 60) {
//       L = -0.2521;
//       M = 12.1119;
//       S = 0.0952;
//     } else {
//       return null; // return null if child is over 5 years old
//     }
//   } else {
//     return null; // return null if gender is invalid
//   }

//   // calculate weight-for-age z-score using LMS method
//   double zScore = ((weight / M).pow(L) - 1) / (S * L);

//   return zScore;/
// }