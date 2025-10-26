import 'package:flutter/material.dart';

void main() {
  runApp(const MeasuresConverterApplication());
}

// Measurements Convertor Application
class MeasuresConverterApplication extends StatelessWidget {
  const MeasuresConverterApplication({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AppPage(),
    );
    }
}

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  AppPageState createState() => AppPageState();
}

class AppPageState extends State<AppPage> {
  final TextEditingController inputValue = TextEditingController();

  String fromUnit = 'miles';
  String toUnit = 'kilometers';
  String result = '';

  final List<String> measures = [
    'kilometers',
    'miles',
    'kilograms',
    'pounds',
  ];

  final Map<String, double> conversionMetrics = {
    'kilometers': 1000.0,
    'miles': 1609.34,
    'kilograms': 1.0,
    'pounds': 0.453592,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measures Converter'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // value field
            inputCSS('Value'),
            TextField(
              controller: inputValue,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.left,
              decoration: const InputDecoration(
                prefix: SizedBox(width: 0)
              ),
            ),
            const SizedBox(height: 20),
            // from field
            inputCSS('From'),
            DropdownButton<String>(
              value: fromUnit,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  fromUnit = newValue!;
                });
              },
              items: measures.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, textAlign: TextAlign.center),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // To field
            inputCSS('To'),
            DropdownButton<String>(
              value: toUnit,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  toUnit = newValue!;
                });
              },
              items: measures.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, textAlign: TextAlign.center),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 130,
                height: 80,
                child: ElevatedButton(
                  onPressed: convertValue,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  // convert button
                  child: const Text(
                    'Convert',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              result,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputCSS(String input) => Text(
              input,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.left,
            );

    // Input Value validation
  void convertValue() {
    // read input
    double? value = double.tryParse(inputValue.text);
    if (value == null) {
      setState(() {
        result = 'Please enter a valid number';
      });
      return;
    }

    double fromRate = conversionMetrics[fromUnit]!;
    double toRate = conversionMetrics[toUnit]!;

    double convertedValue = value * fromRate / toRate;

    setState(() {
      result =
          '$value $fromUnit are $convertedValue $toUnit';
    });
  }
}



