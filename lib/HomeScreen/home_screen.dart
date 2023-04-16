import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;

import '../services/getlocation.dart';

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
          title: const Text('My App'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text('Menu'),
                decoration: BoxDecoration(),
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
                  // Do something when Option 2 is tapped
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const AddChild();
                    }));
                  },
                  child: Text("Add child"))
            ],
          ),
        ));
  }
}

class MalnutritionChecker extends StatefulWidget {
  const MalnutritionChecker({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MalnutritionCheckerState createState() => _MalnutritionCheckerState();
}

class _MalnutritionCheckerState extends State<MalnutritionChecker> {
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
                    // String status =
                    //     getChildMalnutritionStatus(10, 6, 70, 12.5, 45, 110);
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

String calculateMalnutritionStatus(
  int ageInMonths,
  double weight,
  double height,
  String gender,
  double muac,
  double headCircumference,
) {
  // Calculate weight for age (WFA) z-score
  double wfaZScore = calculateWFAZScore(ageInMonths, weight, gender);

  // Calculate height for age (HFA) z-score
  double hfaZScore = calculateHFAZScore(ageInMonths, height, gender);

  // Calculate weight for height (WFH) z-score
  double wfhZScore = calculateWFHZScore(weight, height, gender);

  // Calculate body mass index (BMI) for age z-score
  double bmiZScore = calculateBMIZScore(ageInMonths, weight, height, gender);

  // Determine the malnutrition status based on the WHO criteria
  if (wfaZScore < -3 &&
      wfhZScore < -3 &&
      muac < 115 &&
      headCircumference < 12.5) {
    return 'Severe acute malnutrition (SAM) according to WHO';
  } else if ((wfaZScore < -2 && wfaZScore >= -3) ||
      (hfaZScore < -3 && hfaZScore >= -4)) {
    return 'Moderate acute malnutrition (MAM) according to WHO';
  } else {
    return 'Normal';
  }
}

double calculateWFAZScore(int ageInMonths, double weight, String gender) {
  // TODO: implement WFA z-score calculation
  return 0.0;
}

double calculateHFAZScore(int ageInMonths, double height, String gender) {
  // TODO: implement HFA z-score calculation
  return 0.0;
}

double calculateWFHZScore(double weight, double height, String gender) {
  // TODO: implement WFH z-score calculation
  return 0.0;
}

double calculateBMIZScore(
    int ageInMonths, double weight, double height, String gender) {
  // TODO: implement BMI z-score calculation
  return 0.0;
}

// enum Gender {
//   male,
//   female,
// }

// double calculateWeightForAgeZScore(int ageInMonths, double weight, Gender gender) {
//   double weightInKg = weight / 1000.0;
//   double weightForAgeMedian = gender == Gender.male ? maleWeightForAgeMedian[ageInMonths] : femaleWeightForAgeMedian[ageInMonths];
//   double weightForAgeSd = gender == Gender.male ? maleWeightForAgeSd[ageInMonths] : femaleWeightForAgeSd[ageInMonths];
//   double weightForAgeZScore = (weightInKg - weightForAgeMedian) / weightForAgeSd;
//   return weightForAgeZScore;
// }

// double calculateHeightForAgeZScore(int ageInMonths, double height, Gender gender) {
//   double heightInCm = height / 10.0;
//   double heightForAgeMedian = gender == Gender.male ? maleHeightForAgeMedian[ageInMonths] : femaleHeightForAgeMedian[ageInMonths];
//   double heightForAgeSd = gender == Gender.male ? maleHeightForAgeSd[ageInMonths] : femaleHeightForAgeSd[ageInMonths];
//   double heightForAgeZScore = (heightInCm - heightForAgeMedian) / heightForAgeSd;
//   return heightForAgeZScore;
// }

// double calculateWeightForHeightZScore(int ageInMonths, double weight, double height, Gender gender) {
//   double weightInKg = weight / 1000.0;
//   double heightInM = height / 100.0;
//   double bmi = weightInKg / (heightInM * heightInM);
//   double weightForHeightMedian = gender == Gender.male ? maleWeightForHeightMedian[ageInMonths] : femaleWeightForHeightMedian[ageInMonths];
//   double weightForHeightSd = gender == Gender.male ? maleWeightForHeightSd[ageInMonths] : femaleWeightForHeightSd[ageInMonths];
//   double weightForHeightZScore = ((weightInKg / weightForHeightMedian) - 1) / weightForHeightSd;
//   return weightForHeightZScore;
// }

// double calculateBmiForAgeZScore(int ageInMonths, double weight, double height, Gender gender) {
//   double weightInKg = weight / 1000.0;
//   double heightInM = height / 100.0;
//   double bmi = weightInKg / (heightInM * heightInM);
//   double bmiForAgeMedian = gender == Gender.male ? maleBmiForAgeMedian[ageInMonths] : femaleBmiForAgeMedian[ageInMonths];
//   double bmiForAgeSd = gender == Gender.male ? maleBmiForAgeSd[ageInMonths] : femaleBmiForAgeSd[ageInMonths];
//   double bmiForAgeZScore = (bmi - bmiForAgeMedian) / bmiForAgeSd;
//   return bmiForAgeZScore;
// }

// String getChildMalnutritionStatus(
//     double ageInMonths,
//     double weight,
//     double height,
//     double muac,
//     double headCircumference,
//     double skinfoldThickness) {
//   // calculate z-scores for each measurement
//   double weightZScore = calculateWeightZScore(10, weight, 'male');
//   double heightZScore = calculateHeightZScore(10, height, 0);
//   double muacZScore = calculateMUACZScore(10, 10, 0);
//   double headCircumferenceZScore = calculateHeadCircumferenceZScore(10, 40, 0);
//   double skinfoldThicknessZScore =
//       calculateSkinfoldThicknessZScore(10, skinfoldThickness, 0);

//   // calculate composite z-score
//   double compositeZScore = weightZScore +
//       heightZScore +
//       muacZScore +
//       headCircumferenceZScore +
//       skinfoldThicknessZScore;

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

// double calculateWeightZScore(int ageInMonths, double weight, String gender) {
//   // Define the constants for the WHO growth standards
//   const L = [1.3484, 1.164, 1.1484, 1.1335]; // L values by gender
//   const M = [7.9933, 8.987, 9.8292, 10.4756]; // M values by gender
//   const S = [0.0976, 0.0917, 0.0916, 0.0904]; // S values by gender

//   // Calculate the weight-for-age Z-score (WAZ) using the WHO formula
//   double weightInKg = weight / 1000.0; // convert weight from grams to kg
//   double weightByAge = 0.0;
//   double zScore = 0.0;

//   // Find the appropriate LMS values based on the child's gender
//   int genderIndex = gender == 'male' ? 0 : 1;
//   if (ageInMonths < 24) {
//     weightByAge = ((weightInKg / M[genderIndex]) /
//         math.pow((ageInMonths / 12), L[genderIndex]));
//     zScore = ((weightByAge / S[genderIndex]) - 1.0) * 100.0;
//   } else {
//     weightByAge =
//         ((weightInKg / M[2 + genderIndex]) / math.pow(2, L[2 + genderIndex]));
//     zScore = ((weightByAge / S[2 + genderIndex]) - 1.0) * 100.0;
//   }

//   return zScore;
// }

// double calculateHeightZScore(int ageInMonths, double height, int gender) {
//   double L, M;

//   // Look up L and M values in the WHO height-for-age z-score table
//   if (gender == 0) {
//     // Male
//     if (ageInMonths < 24) {
//       L = -0.544;
//       M = 77.389;
//     } else {
//       L = 0.903;
//       M = 83.378;
//     }
//   } else {
//     // Female
//     if (ageInMonths < 24) {
//       L = -0.409;
//       M = 76.323;
//     } else {
//       L = 1.249;
//       M = 78.471;
//     }
//   }

//   // Calculate the height z-score
//   double heightZScore = (height - L) / M;

//   return heightZScore;
// }

// double calculateMUACZScore(int ageInMonths, double muac, int gender) {
//   double L, M;

//   // Look up L and M values in the WHO MUAC-for-age z-score table
//   if (gender == 0) {
//     // Male
//     if (ageInMonths < 6) {
//       L = 12.76;
//       M = 0.1681;
//     } else if (ageInMonths >= 6 && ageInMonths < 12) {
//       L = 13.06;
//       M = 0.1577;
//     } else if (ageInMonths >= 12 && ageInMonths < 24) {
//       L = 13.33;
//       M = 0.1469;
//     } else if (ageInMonths >= 24 && ageInMonths < 60) {
//       L = 14.26;
//       M = 0.1334;
//     } else {
//       // age >= 60 months
//       L = 15.04;
//       M = 0.1229;
//     }
//   } else {
//     // Female
//     if (ageInMonths < 6) {
//       L = 12.20;
//       M = 0.1674;
//     } else if (ageInMonths >= 6 && ageInMonths < 12) {
//       L = 12.55;
//       M = 0.1557;
//     } else if (ageInMonths >= 12 && ageInMonths < 24) {
//       L = 12.86;
//       M = 0.1438;
//     } else if (ageInMonths >= 24 && ageInMonths < 60) {
//       L = 13.75;
//       M = 0.1297;
//     } else {
//       // age >= 60 months
//       L = 14.53;
//       M = 0.1186;
//     }
//   }

//   // Calculate the MUAC z-score
//   double muacZScore = (muac - L) / M;

//   return muacZScore;
// }

// double calculateHeadCircumferenceZScore(
//     int ageInMonths, double headCircumference, int gender) {
//   // Convert head circumference from cm to mm
//   double headCircumferenceMM = headCircumference * 10.0;

//   // Find the appropriate L, M, and S values based on gender and age
//   double l, m, s;
//   if (gender == 0) {
//     if (ageInMonths < 24) {
//       l = -0.2414;
//       m = 472.9497;
//       s = 0.05294;
//     } else if (ageInMonths >= 24 && ageInMonths <= 36) {
//       l = -0.1485;
//       m = 493.0524;
//       s = 0.05371;
//     } else {
//       l = -0.1085;
//       m = 511.7354;
//       s = 0.05258;
//     }
//   } else {
//     if (ageInMonths < 24) {
//       l = -0.2607;
//       m = 454.4500;
//       s = 0.05376;
//     } else if (ageInMonths >= 24 && ageInMonths <= 36) {
//       l = -0.1907;
//       m = 468.9917;
//       s = 0.05336;
//     } else {
//       l = -0.1620;
//       m = 484.4141;
//       s = 0.05272;
//     }
//   }

//   // Calculate the expected head circumference (in mm) based on age and gender
//   double expectedHeadCircumference = m * math.pow(ageInMonths, l);

//   // Calculate the standard deviation of the head circumference based on age, gender, and S value
//   double sd = s * expectedHeadCircumference;

//   // Calculate the z-score for the observed head circumference
//   double zScore =
//       (math.log(headCircumferenceMM) - math.log(expectedHeadCircumference)) /
//           math.log(10) *
//           sd;

//   return zScore;
// }

// double calculateSkinfoldThicknessZScore(
//     int ageInMonths, double skinfoldThickness, int gender) {
//   double zScore = 0.0;

//   // Calculate mean and standard deviation based on age, gender, and skinfold thickness values
//   double mean = 0.0;
//   double sd = 0.0;

//   if (gender == 0) {
//     if (ageInMonths < 24) {
//       mean = 0.1107 * ageInMonths + 1.5707;
//       sd = 0.1177;
//     } else {
//       mean = 0.1107 * ageInMonths + 1.5707;
//       sd = 0.1169;
//     }
//   } else {
//     if (ageInMonths < 24) {
//       mean = 0.1122 * ageInMonths + 1.5842;
//       sd = 0.1174;
//     } else {
//       mean = 0.1122 * ageInMonths + 1.5842;
//       sd = 0.1181;
//     }
//   }

//   // Calculate z-score based on mean and standard deviation
//   zScore = (skinfoldThickness - mean) / sd;

//   return zScore;
// }
