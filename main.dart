import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController nameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bmiController = TextEditingController(); // Added BMI controller
  String gender = 'Male';
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'YourFullname'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: 'Height (centimeters)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: 'Weight (kilograms)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: bmiController,
              readOnly: true,
              decoration: InputDecoration(labelText: 'BMI Value'),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Gender:'),
                SizedBox(width: 10),
                Radio(
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text('Male'),
                SizedBox(width: 10),
                Radio(
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text('Female'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateBMI();
              },
              child: Text('Calculate and Save'),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(result),
            ),
          ],
        ),
      ),
    );
  }


  void calculateBMI() {
    String name = nameController.text;
    double height = double.parse(heightController.text);
    double weight = double.parse(weightController.text);

    double bmi = weight / pow((height/ 100),2);
    String bmiCategory = _getBMICategory(bmi);

    setState(() {
      result = '''
       
        $gender $bmiCategory
      ''';
      bmiController.text = bmi.toStringAsFixed(2);
    });
  }

  String _getBMICategory(double bmi) {
    if (gender == 'Male') {
      if (bmi < 18.5) {
        return 'Underweight. Careful during strong wind!';
      } else if (bmi >= 18.5 && bmi < 25) {
        return 'That’s ideal! Please maintain';
      } else if (bmi >= 25 && bmi < 30) {
        return 'Overweight! Work out please';
      } else {
        return 'Whoa Obese! Dangerous mate!';
      }
    } else {
      // For female
      if (bmi < 16) {
        return 'Underweight. Careful during strong wind!';
      } else if (bmi >= 16 && bmi < 22) {
        return 'That’s ideal! Please maintain';
      } else if (bmi >= 22 && bmi < 27) {
        return 'Overweight! Work out please';
      } else {
        return 'Whoa Obese! Dangerous mate!';
      }
    }
  }
}
