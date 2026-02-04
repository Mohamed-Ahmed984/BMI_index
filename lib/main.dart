import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

enum Gender { male, female }

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BmiScreen(),
    );
  }
}

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  int height = 180;
  int weight = 80;
  int age = 33;
  Gender? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a0c21),
      appBar: AppBar(
        backgroundColor: const Color(0xff0a0c21),
        centerTitle: true,
        title: const Text("BMI Screen"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                _genderCard(Icons.male, "Male", Gender.male),
                _genderCard(Icons.female, "Female", Gender.female),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xff1d1e33),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Height", style: TextStyle(color: Colors.white70)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        height.toString(),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(" cm", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Slider(
                    value: height.toDouble(),
                    min: 120,
                    max: 220,
                    activeColor: const Color(0xffeb1555),
                    inactiveColor: Colors.white24,
                    onChanged: (value) {
                      setState(() {
                        height = value.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                _valueCard(
                  "Weight",
                  weight,
                  () => setState(() => weight--),
                  () => setState(() => weight++),
                ),
                _valueCard(
                  "Age",
                  age,
                  () => setState(() => age--),
                  () => setState(() => age++),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffeb1555),
              ),
              onPressed: () {
                double bmi = weight / ((height / 100) * (height / 100));
                String result;
                if (bmi >= 25) {
                  result = "Overweight";
                } else if (bmi > 18.5) {
                  result = "Healthy Weight";
                } else {
                  result = "Underweight";
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ResultScreen(bmi: bmi, resultText: result),
                  ),
                );
              },
              child: const Text(
                "Calculate",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _genderCard(IconData icon, String text, Gender gender) {
    bool isSelected = selectedGender == gender;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedGender = gender;
          });
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xffeb1555)
                : const Color(0xff1d1e33),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 80, color: Colors.white),
              const SizedBox(height: 10),
              Text(text, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _valueCard(
    String title,
    int value,
    VoidCallback minus,
    VoidCallback plus,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xff1d1e33),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(color: Colors.white70)),
            Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: minus,
                  icon: const Icon(Icons.remove, color: Colors.white),
                ),
                IconButton(
                  onPressed: plus,
                  icon: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final double bmi;
  final String resultText;

  const ResultScreen({super.key, required this.bmi, required this.resultText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a0c21),
      appBar: AppBar(
        backgroundColor: const Color(0xff0a0c21),
        centerTitle: true,
        title: const Text("BMI Result"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              resultText,
              style: const TextStyle(
                color: Colors.greenAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Your BMI is: ${bmi.toStringAsFixed(2)}",
              style: const TextStyle(color: Colors.white, fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
