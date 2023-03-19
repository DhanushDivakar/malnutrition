import 'package:flutter/material.dart';

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
                    double age = double.tryParse(_ageController.text) ?? 0.0;
                    double weight =
                        double.tryParse(_weightController.text) ?? 0.0;
                    double height =
                        double.tryParse(_heightController.text) ?? 0.0;
                    double muac = double.tryParse(_muacController.text) ?? 0.0;
                    double headCircumference =
                        double.tryParse(_headCircumferenceController.text) ??
                            0.0;
                    double skinfoldThickness =
                        double.tryParse(_skinfoldThicknessController.text) ??
                            0.0;

                    // Calculate BMI
                    double heightInMeters = height / 100;
                    double bmi = weight / (heightInMeters * heightInMeters);
                    print(bmi);
                   
                        
                    setState(() {
                        malnutritionStatus = getMalnutritionStatus(
                        age, bmi, muac, headCircumference, skinfoldThickness);
                      
                    });
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

String getMalnutritionStatus(double age, double bmi, double muac,
    double headCircumference, double skinfoldThickness) {
  String status = '';

  if (age < 6) {
    if (bmi < 16) {
      status = 'Severe Acute Malnutrition';
    } else if (bmi >= 16 && bmi < 17) {
      status = 'Moderate Acute Malnutrition';
    } else if (bmi >= 17 && bmi < 18.5) {
      status = 'Mild Acute Malnutrition';
    } else {
      status = 'Normal';
    }
  } else {
    if (bmi < 18.5) {
      if (muac < 12.5) {
        status = 'Severe Chronic Malnutrition';
      } else if (muac >= 12.5 && muac < 13.5) {
        status = 'Moderate Chronic Malnutrition';
      } else if (muac >= 13.5 && muac < 14.5) {
        status = 'Mild Chronic Malnutrition';
      } else {
        status = 'Normal';
      }
    } else {
      if (headCircumference < 31) {
        status = 'Microcephaly';
      } else if (headCircumference >= 31 && headCircumference < 34) {
        status = 'Normal Head Circumference';
      } else {
        status = 'Macrocephaly';
      }

      if (skinfoldThickness >= 10) {
        status += ' with Excess Fat';
      } else {
        status += ' with Normal Fat';
      }
    }
  }

  return status;
}
