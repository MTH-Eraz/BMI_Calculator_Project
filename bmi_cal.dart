// bmi_cal.dart

import 'package:flutter/material.dart';
import 'input_fuild.dart';


enum WeightUnit { kg, lb }
enum HeightUnit { m, cm, ftIn }

class bmiCal extends StatefulWidget {
  const bmiCal({super.key});

  @override
  State<bmiCal> createState() => _bmiCalState();
}

class _bmiCalState extends State<bmiCal> {

  WeightUnit _weightUnit = WeightUnit.kg;
  HeightUnit _heightUnit = HeightUnit.cm;


  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightMController = TextEditingController();
  final TextEditingController _heightCmController = TextEditingController();
  final TextEditingController _heightFeetController = TextEditingController();
  final TextEditingController _heightInchController = TextEditingController();


  String _bmiResult = '';
  String? _category;




  double? getWeightInKg() {
    final weight = double.tryParse(_weightController.text.trim());
    if (weight == null || weight <= 0) {
      _showSnackBar('Please enter a valid weight.');
      return null;
    }


    if (_weightUnit == WeightUnit.lb) {
      return weight * 0.45359237;
    }
    return weight;
  }


  double? getHeightInMeter() {
    double? heightInMeter;

    if (_heightUnit == HeightUnit.m) {
      heightInMeter = double.tryParse(_heightMController.text.trim());

    } else if (_heightUnit == HeightUnit.cm) {
      final heightCm = double.tryParse(_heightCmController.text.trim());
      if (heightCm != null && heightCm > 0) {
        heightInMeter = heightCm / 100; // m = cm / 100
      }

    } else if (_heightUnit == HeightUnit.ftIn) {
      final feet = double.tryParse(_heightFeetController.text.trim()) ?? 0.0;
      final inch = double.tryParse(_heightInchController.text.trim()) ?? 0.0;

      if (feet <= 0 && inch <= 0) {
        _showSnackBar('Please enter a valid height in feet and inch.');
        return null;
      }
      // m = (feet × 12 + inch) × 0.0254
      heightInMeter = (feet * 12 + inch) * 0.0254;
    }

    if (heightInMeter == null || heightInMeter <= 0) {
      _showSnackBar('Please enter a valid height.');
      return null;
    }
    return heightInMeter;
  }

  void calculateBMI() {
    final weightKg = getWeightInKg();
    final heightMeter = getHeightInMeter();

    if (weightKg == null || heightMeter == null) {
      return; // Invalid input handled by helper functions
    }

    // BMI = weight_kg / (height_m)^2
    final bmi = weightKg / (heightMeter * heightMeter);
    final category = getBMICategory(bmi);

    setState(() {
      _bmiResult = bmi.toStringAsFixed(1); // 1 decimal place
      _category = category;
    });
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 25.0) { // 18.5 – 24.9
      return 'Normal';
    } else if (bmi < 30.0) { // 25.0 – 29.9
      return 'Overweight';
    } else { // ≥ 30.0
      return 'Obese';
    }
  }

  Color _getCategoryColor(String? category) {
    switch (category) {
      case 'Underweight':
        return Colors.blue.shade600;
      case 'Normal':
        return Colors.green.shade600;
      case 'Overweight':
        return Colors.orange.shade600;
      case 'Obese':
        return Colors.red.shade600;
      default:
        return Colors.black;
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // --- UI/Build Method ---

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Colors.blue;
    const Color lightTextColor = Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'BMI Calculator',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // --- 1. Weight Input Section ---
            _buildSectionHeader('Weight Unit (KG / LB)'),
            const SizedBox(height: 10),

            SegmentedButton<WeightUnit>(
              segments: const [
                ButtonSegment<WeightUnit>(value: WeightUnit.kg, label: Text('KG')),
                ButtonSegment<WeightUnit>(value: WeightUnit.lb, label: Text('LB')),
              ],
              selected: {_weightUnit},
              onSelectionChanged: (value) {
                setState(() {
                  _weightUnit = value.first;
                });
              },
              style: SegmentedButton.styleFrom(selectedBackgroundColor: primaryColor),
            ),
            const SizedBox(height: 10),

            Appinputfuild(
              controller: _weightController,
              labelText: 'Enter weight in ${_weightUnit.name.toUpperCase()}',
              isDecimal: true,
            ),
            const SizedBox(height: 40),

            // --- 2. Height Input Section ---
            _buildSectionHeader('Height Unit (M / CM / FT+IN)'),
            const SizedBox(height: 10),

            SegmentedButton<HeightUnit>(
              segments: const [
                ButtonSegment<HeightUnit>(value: HeightUnit.m, label: Text('Meter (m)')),
                ButtonSegment<HeightUnit>(value: HeightUnit.cm, label: Text('CM')),
                ButtonSegment<HeightUnit>(value: HeightUnit.ftIn, label: Text('Ft + In')),
              ],
              selected: {_heightUnit},
              onSelectionChanged: (value) {
                setState(() {
                  _heightUnit = value.first;
                });
              },
              style: SegmentedButton.styleFrom(selectedBackgroundColor: primaryColor),
            ),
            const SizedBox(height: 10),

            // Height Input Fields based on selection
            if (_heightUnit == HeightUnit.m)
              Appinputfuild(
                controller: _heightMController,
                labelText: 'Enter height in Meter (m)',
                isDecimal: true,
              )
            else if (_heightUnit == HeightUnit.cm)
              Appinputfuild(
                controller: _heightCmController,
                labelText: 'Enter height in CM',
                isDecimal: true,
              )
            else // HeightUnit.ftIn
              Row(
                children: [
                  Expanded(
                    child: Appinputfuild(
                      controller: _heightFeetController,
                      labelText: 'Feet (ft)',
                      isDecimal: false, // Feet should typically be integer
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Appinputfuild(
                      controller: _heightInchController,
                      labelText: 'Inches (in)',
                      isDecimal: true,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 30),

            // --- 3. Calculate Button ---
            ElevatedButton(
              onPressed: calculateBMI,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Calculate BMI',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 40),

            // --- 4. BMI Result Section ---
            if (_bmiResult.isNotEmpty)
              _buildResultCard(primaryColor),
          ],
        ),
      ),
    );
  }

  // Helper widget for Section Headers
  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  // Helper widget for Result Display
  Widget _buildResultCard(Color primaryColor) {
    final categoryColor = _getCategoryColor(_category);

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Your BMI Score',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 5),
            Text(
              _bmiResult,
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w900,
                color: categoryColor,
              ),
            ),
            const SizedBox(height: 20),

            Chip(
              avatar: Icon(Icons.fitness_center, color: categoryColor),
              label: Text(
                _category ?? 'Unknown',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: categoryColor,
                ),
              ),
              backgroundColor: categoryColor.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: categoryColor, width: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}