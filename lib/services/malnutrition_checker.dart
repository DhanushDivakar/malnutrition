// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import "dart:math" as Math;

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
  String? _selectedGender;

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

  final List<String> _genders = <String>[
    'male',
    'female',
  ];
  String calculateMalnutrition(
      double age, double height, double weight, String gender) {
    if (age > 5) {
      return "This function only applies to children under 5 years old.";
    }

    double zScore = 0.0;

    if (gender == "male") {
      zScore = calculateZScoreForBoys(age, height, weight);
    } else {
      zScore = calculateZScoreForGirls(age, height, weight);
    }

    if (zScore < -3) {
      return "Severe malnutrition";
    } else if (zScore < -2) {
      return "Moderate malnutrition";
    } else if (zScore < -1) {
      return "Mild malnutrition";
    } else {
      return "Normal";
    }
  }

  double calculateZScoreForBoys(double age, double height, double weight) {
    // Constants for the L, M, and S values for the WHO Boys weight-for-height percentiles
    const List<double> L = [
      -0.3529,
      -0.3537,
      -0.3820,
      -0.4364,
      -0.5367,
      -0.6847,
      -0.8770,
      -1.1072,
      -1.3739,
      -1.6797,
      -2.0275
    ];
    const List<double> M = [
      7.5595,
      8.0452,
      8.5259,
      9.0166,
      9.5303,
      10.0783,
      10.6711,
      11.3208,
      12.0393,
      12.8381,
      13.7272
    ];
    const List<double> S = [
      0.09193,
      0.09268,
      0.09635,
      0.10609,
      0.12381,
      0.15232,
      0.19454,
      0.25300,
      0.32942,
      0.42688,
      0.54853
    ];

    // Find the weight-for-height z-score for the given age, height, and weight
    double HAZ = calculateHAZForBoys(age, height, weight);
    double weightForHeight = weight / (height * height);
    double weightForHeightM = calculateWeightForHeightMForBoys(age, height);

    double WAZ = (Math.log(weightForHeight / weightForHeightM) / Math.log(10) -
            L[age.toInt() - 1]) /
        S[age.toInt() - 1];
    double WHZ = HAZ + WAZ;

    return WHZ;
    // TODO: Implement the WHO Boys Z-score calculation for the given age, height, and weight
  }

  double calculateHAZForBoys(double age, double height, double weight) {
    // Constants for the L, M, and S values for the WHO Boys height-for-age percentiles
    const List<double> L = [
      -1.8781,
      -1.8986,
      -1.9052,
      -1.8954,
      -1.8661,
      -1.8157,
      -1.7424,
      -1.6462,
      -1.5313,
      -1.4035,
      -1.2679,
      -1.1304,
      -0.9964,
      -0.8717,
      -0.7611,
      -0.6649,
      -0.5841,
      -0.5188,
      -0.4689,
      -0.4338,
      -0.4132,
      -0.4067,
      -0.4141,
      -0.4351,
      -0.4695,
      -0.5173,
      -0.5783,
      -0.6523,
      -0.7391,
      -0.8387,
      -0.9509,
      -1.0756,
      -1.2128,
      -1.3623,
      -1.5239,
      -1.6976,
      -1.8831,
      -2.0804,
      -2.2892,
      -2.5096,
      -2.7411,
      -2.9837,
      -3.2370,
      -3.5011,
      -3.7761,
      -4.0620
    ];
    const List<double> M = [
      49.8842,
      53.7585,
      57.0273,
      60.1396,
      63.2840,
      66.4471,
      69.6189,
      72.7912,
      75.9562,
      79.1062,
      82.2337,
      85.3321,
      88.3951,
      91.4163,
      94.3897,
      97.3093,
      100.1693,
      102.9641,
      105.6881,
      108.3368,
      110.9062,
      113.3922,
      115.7913,
      118.1002,
      120.3162,
      122.4372,
      124.4607,
      126.3851,
      128.2096,
      129.9340,
      131.5587,
      133.0845,
      134.5136,
      135.8498,
      137.0976,
      138.2624,
      139.3505,
      140.3695,
      141.3266,
      142.2285,
      143.0827,
      143.8975,
      144.6813,
      145.4429,
      146.1911,
      146.9345
    ];
    const List<double> S = [
      0.09750,
      0.09846,
      0.10030,
      0.10304,
      0.10670,
      0.11132,
      0.11691,
      0.12351,
      0.13115,
      0.13987,
      0.14967,
      0.16058,
      0.17264,
      0.18587,
      0.20031,
      0.21600,
      0.23298,
      0.25130,
      0.27100,
      0.29212,
      0.31470,
      0.33877,
      0.36437,
      0.39154,
      0.42031,
      0.45072,
      0.48280,
      0.51657,
      0.55207,
      0.58930,
      0.62829,
      0.66906,
      0.71162,
      0.75597,
      0.80211,
      0.85001,
      0.89968,
      0.95113,
      1.00435,
      1.05934,
      1.11610,
      1.17463,
      1.23494,
      1.29702,
      1.36087,
      1.42650
    ];

    // Find the height-for-age z-score for the given age, height, and weight
    double heightForAge = height / M[age.toInt() - 1];

    double HAZ = (Math.log(heightForAge) / Math.log(10) - L[age.toInt() - 1]) /
        S[age.toInt() - 1];

    return HAZ;
  }

  double calculateWeightForHeightMForBoys(double age, double height) {
    // Constants for the L, M, and S values for the WHO Boys weight-for-height percentiles
    const List<double> L = [
      -0.3529,
      -0.3537,
      -0.3820,
      -0.4364,
      -0.5367,
      -0.6847,
      -0.8770,
      -1.1072,
      -1.3739,
      -1.6797,
      -2.0275
    ];
    const List<double> M = [
      7.5595,
      8.0452,
      8.5259,
      9.0166,
      9.5303,
      10.0783,
      10.6711,
      11.3208,
      12.0393,
      12.8381,
      13.7272
    ];
    const List<double> S = [
      0.09193,
      0.09268,
      0.09635,
      0.10609,
      0.12381,
      0.15232,
      0.19454,
      0.25300,
      0.32942,
      0.42688,
      0.54853
    ];

    // Find the median weight-for-height for the given age and height
    double Z = 0.0;
    double weightForHeightM = 0.0;
    double heightM = M[age.toInt() - 1];

    if (height < heightM) {
      Z = (Math.log(height / heightM) / Math.log(10)) / S[age.toInt() - 1];
      weightForHeightM = M[age.toInt() - 1] *
          Math.pow(10, L[age.toInt() - 1] + S[age.toInt() - 1] * Z);
    } else {
      Z = (Math.log(height / heightM) / Math.log(10)) / S[age.toInt()];
      weightForHeightM =
          M[age.toInt()] * Math.pow(10, L[age.toInt()] + S[age.toInt()] * Z);
    }

    return weightForHeightM;
  }

  double calculateZScoreForGirls(double age, double height, double weight) {
    // Constants for the L, M, and S values for the WHO Girls weight-for-age percentiles

    const List<double> LGIRLS_WFA_L = [
      1.381,
      1.433,
      1.48,
      1.523,
      1.56,
      1.592,
      1.62,
      1.644,
      1.664,
      1.681,
      1.694,
      1.703,
      1.709,
      1.711,
      1.71,
      1.706,
      1.7,
      1.691,
      1.681,
      1.669,
      1.655,
      1.641,
      1.625,
      1.609,
      1.592,
      1.576,
      1.56,
      1.543,
      1.526,
      1.51,
      1.494,
      1.478,
      1.463,
      1.448,
      1.434,
      1.421,
      1.408,
      1.396,
      1.385,
      1.375,
      1.365,
      1.356,
      1.347,
      1.339,
      1.332,
      1.325,
      1.318,
      1.312,
      1.306,
      1.3
    ];
    const List<double> MGIRLS_WFA_M = [
      3.5,
      4.2,
      5.0,
      5.8,
      6.5,
      7.2,
      7.9,
      8.6,
      9.3,
      10.0,
      10.7,
      11.4,
      12.1,
      12.8,
      13.5,
      14.2,
      14.9,
      15.6,
      16.3,
      16.9,
      17.6,
      18.2,
      18.8,
      19.4,
      20.0,
      20.6,
      21.1,
      21.7,
      22.2,
      22.7,
      23.2,
      23.7,
      24.2,
      24.6,
      25.1,
      25.5,
      26.0,
      26.4,
      26.8,
      27.2,
      27.6,
      28.0,
      28.4,
      28.8,
      29.1,
      29.5,
      29.9
    ];

    const List<double> SGIRLS_WFA_S = [
      0.0974857008,
      0.0915292739,
      0.086747535,
      0.082873399,
      0.079689145,
      0.077026847,
      0.074748522,
      0.072758577,
      0.071000315,
      0.069429528,
      0.068008228,
      0.066703558,
      0.065488068,
      0.064341526,
      0.063249025,
      0.062198712,
      0.061181246,
      0.060189177,
      0.059216384,
      0.058257217,
      0.057306222,
      0.056362554,
      0.055425938,
      0.05449617,
      0.05357308,
      0.052656526,
      0.051746373,
      0.050842503,
      0.049944801,
      0.049053161,
      0.04816748,
      0.047287661,
      0.046413604,
      0.045545215,
      0.044682401,
      0.043825069,
      0.04297313,
      0.042126495,
      0.041285078,
      0.040448794,
      0.03961756,
      0.038791293,
      0.037969911,
      0.037153333,
      0.03634148,
      0.035534275,
      0.034731643
    ];

    // Constants for the L, M, and S values for the WHO Girls height-for-age percentiles

    const List<double> LGIRLS_HFA_L = [
      -1.9365,
      -2.1418,
      -2.3213,
      -2.4711,
      -2.5958,
      -2.6995,
      -2.7854,
      -2.8564,
      -2.9144,
      -2.9611,
      -2.9981,
      -3.0268,
      -3.0482,
      -3.0633,
      -3.0729,
      -3.0776,
      -3.0780,
      -3.0747,
      -3.0681,
      -3.0586,
      -3.0465,
      -3.0321,
      -3.0158,
      -2.9976,
      -2.9777,
      -2.9564,
      -2.9339,
      -2.9102,
      -2.8857,
      -2.8602,
      -2.8340,
      -2.8071,
      -2.7797,
      -2.7518,
      -2.7236,
      -2.6950,
      -2.6661,
      -2.6369,
      -2.6075,
      -2.5779,
      -2.5481,
      -2.5181,
      -2.4879,
      -2.4576,
      -2.4272,
      -2.3967,
      -2.3660,
      -2.3353
    ];

    const List<double> MGIRLS_HFA_M = [
      49.8842,
      53.4969,
      56.7009,
      59.6443,
      62.4048,
      65.0250,
      67.5296,
      69.9385,
      72.2676,
      74.5305,
      76.7386,
      78.9011,
      81.0254,
      83.1184,
      85.1846,
      87.2275,
      89.2489,
      91.2504,
      93.2334,
      95.1987,
      97.1468,
      99.0779,
      100.9923,
      102.8903,
      104.7722,
      106.6382,
      108.4886,
      110.3237,
      112.1438,
      113.9491,
      115.7398,
      117.5161,
      119.2782,
      121.0263,
      122.7606,
      124.4811,
      126.1882,
      127.8820,
      129.5626,
      131.2302,
      132.8849,
      134.5267,
      136.1558,
      137.7723,
      139.3763,
      140.9680,
      142.5474
    ];

    const List<double> SGIRLS_HFA_S = [
      0.0379,
      0.0377,
      0.0376,
      0.0375,
      0.0374,
      0.0373,
      0.0372,
      0.0371,
      0.0370,
      0.0369,
      0.0368,
      0.0367,
      0.0366,
      0.0366,
      0.0365,
      0.0364,
      0.0363,
      0.0362,
      0.0361,
      0.0361,
      0.0360,
      0.0359,
      0.0358,
      0.0357,
      0.0357,
      0.0356,
      0.0355,
      0.0354,
      0.0353,
      0.0353,
      0.0352,
      0.0351,
      0.0350,
      0.0349,
      0.0349,
      0.0348,
      0.0347,
      0.0346,
      0.0345,
      0.0345,
      0.0344,
      0.0343,
      0.0342,
      0.0342,
      0.0341,
      0.0340,
      0.0339,
      0.0339,
      0.0338
    ];

    // Calculate weight-for-age Z-score
    int ageIndex = age.floor();
    double zWFA = (weight - MGIRLS_WFA_M[ageIndex]) /
        (SGIRLS_WFA_S[ageIndex] *
            Math.pow(MGIRLS_WFA_M[ageIndex], LGIRLS_WFA_L[ageIndex]));

    // Calculate height-for-age Z-score
    double zHFA = (height - MGIRLS_HFA_M[ageIndex]) /
        (SGIRLS_HFA_S[ageIndex] *
            Math.pow(MGIRLS_HFA_M[ageIndex], LGIRLS_HFA_L[ageIndex]));

    // Calculate the average of the two Z-scores and return the result
    return (zWFA + zHFA) / 2;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: const Text('Malnutrition Cheker'),
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
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.85,
                    child: Text(
                      'Gender: ',
                      style: TextStyle(
                        fontSize: height * 0.025,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.transparent,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                        child: DropdownButton<String>(
                          underline: const SizedBox(),
                          value: _selectedGender,
                          items: _genders
                              .map((gender) => DropdownMenuItem<String>(
                                    value: gender,
                                    child: Text(gender),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          borderRadius: BorderRadius.circular(10),
                          isExpanded: true,
                        ),
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
                    double age = double.tryParse(_ageController.text) ?? 0.0;
                    double height =
                        double.tryParse(_heightController.text) ?? 0.0;
                    double weight =
                        double.tryParse(_weightController.text) ?? 0.0;

                    String gender = _selectedGender ?? 'male';

                    malnutritionStatus =
                        calculateMalnutrition(age, 15, 80, gender);
                    print(malnutritionStatus);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Check',
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
                'Result:  $malnutritionStatus',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GenderInput extends StatefulWidget {
  const GenderInput({Key? key}) : super(key: key);

  @override
  _GenderInputState createState() => _GenderInputState();
}

class _GenderInputState extends State<GenderInput> {
  String? _selectedGender;

  final List<String> _genders = <String>[
    'Male',
    'Female',
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.85,
          child: Text(
            'Gender: ',
            style: TextStyle(
              fontSize: height * 0.025,
            ),
          ),
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.transparent,
              border: Border.all(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: DropdownButton<String>(
                underline: const SizedBox(),
                value: _selectedGender,
                items: _genders
                    .map((gender) => DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                borderRadius: BorderRadius.circular(10),
                isExpanded: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
