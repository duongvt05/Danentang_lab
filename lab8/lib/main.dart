import 'package:flutter/material.dart';

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0A0E21),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
      ),
      home: const InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  int height = 180;
  int weight = 60;
  int age = 20;
  String gender = "male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("BMI CALCULATOR"))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Gender row
          Expanded(
            child: Row(
              children: [
                buildGenderCard("male", Icons.male),
                buildGenderCard("female", Icons.female),
              ],
            ),
          ),

          // Height card
          Expanded(
            child: ReusableCard(
              color: const Color(0xFF1D1E33),
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("HEIGHT", style: TextStyle(fontSize: 18)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        height.toString(),
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Text("cm"),
                    ],
                  ),
                  Slider(
                    value: height.toDouble(),
                    min: 120.0,
                    max: 220.0,
                    activeColor: Colors.pink,
                    inactiveColor: Colors.grey,
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

          // Weight + Age
          Expanded(
            child: Row(
              children: [
                buildValueCard(
                  "WEIGHT",
                  weight,
                  () {
                    setState(() => weight--);
                  },
                  () {
                    setState(() => weight++);
                  },
                ),
                buildValueCard(
                  "AGE",
                  age,
                  () {
                    setState(() => age--);
                  },
                  () {
                    setState(() => age++);
                  },
                ),
              ],
            ),
          ),

          // Calculate button
          GestureDetector(
            onTap: () {
              double bmi = weight / ((height / 100) * (height / 100));
              String result;
              if (bmi < 18.5) {
                result = "Thiếu cân";
              } else if (bmi < 25) {
                result = "Bình thường";
              } else {
                result = "Thừa cân";
              }

              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Kết quả BMI"),
                  content: Text(
                    "BMI: ${bmi.toStringAsFixed(1)}\nPhân loại: $result",
                  ),
                ),
              );
            },
            child: Container(
              color: Colors.pink,
              height: 80,
              width: double.infinity,
              child: const Center(
                child: Text(
                  "CALCULATE",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Card chọn giới tính
  Expanded buildGenderCard(String value, IconData icon) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            gender = value;
          });
        },
        child: ReusableCard(
          color: gender == value ? Colors.pink : const Color(0xFF1D1E33),
          cardChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 80),
              Text(
                value.toUpperCase(),
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Card cho Weight/Age
  Expanded buildValueCard(
    String label,
    int value,
    VoidCallback onMinus,
    VoidCallback onPlus,
  ) {
    return Expanded(
      child: ReusableCard(
        color: const Color(0xFF1D1E33),
        cardChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontSize: 18)),
            Text(
              value.toString(),
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: onMinus,
                  backgroundColor: Colors.grey[800],
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: onPlus,
                  backgroundColor: Colors.grey[800],
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Reusable Card
class ReusableCard extends StatelessWidget {
  final Color color;
  final Widget cardChild;

  const ReusableCard({super.key, required this.color, required this.cardChild});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: cardChild,
    );
  }
}