// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(const PayCalculatorApp());
}

class PayCalculatorApp extends StatelessWidget {
  const PayCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PayCalculatorScreen(),
    );
  }
}

class PayCalculatorScreen extends StatefulWidget {
  const PayCalculatorScreen({super.key});

  @override
  _PayCalculatorScreenState createState() => _PayCalculatorScreenState();
}

class _PayCalculatorScreenState extends State<PayCalculatorScreen> {
  TextEditingController hoursWorkedController = TextEditingController();
  TextEditingController hourlyRateController = TextEditingController();

  double regularPay = 0.0;
  double overtimePay = 0.0;
  double totalPay = 0.0;
  double tax = 0.0;

  String hoursWorkedError = '';
  String hourlyRateError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Input your work details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: hoursWorkedController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Hours Worked',
                errorText:
                    hoursWorkedError.isNotEmpty ? hoursWorkedError : null,
              ),
            ),
            TextField(
              controller: hourlyRateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Hourly Rate',
                errorText: hourlyRateError.isNotEmpty ? hourlyRateError : null,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  hoursWorkedError = hoursWorkedController.text.isEmpty
                      ? 'This field is required'
                      : '';
                  hourlyRateError = hourlyRateController.text.isEmpty
                      ? 'This field is required'
                      : '';

                  if (hoursWorkedError.isEmpty && hourlyRateError.isEmpty) {
                    calculatePay();
                  }
                });
              },
              child: const Text('Calculate Pay'),
            ),
            const SizedBox(height: 20),
            Text(
              'Regular Pay: \$${regularPay.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Overtime Pay: \$${overtimePay.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Total Pay: \$${totalPay.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Tax: \$${tax.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            const Text(
              'My Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Your Name - Nkemjika Obi',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'Your College ID - 301275091',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void calculatePay() {
    double hoursWorked = double.tryParse(hoursWorkedController.text) ?? 0.0;
    double hourlyRate = double.tryParse(hourlyRateController.text) ?? 0.0;

    double overtimeHours = 0.0;
    if (hoursWorked > 40) {
      overtimeHours = hoursWorked - 40;
      hoursWorked = 40;
    }

    regularPay = hoursWorked * hourlyRate;
    overtimePay = overtimeHours * hourlyRate * 1.5;
    totalPay = regularPay + overtimePay;
    tax = totalPay * 0.18;

    setState(() {});
  }
}
