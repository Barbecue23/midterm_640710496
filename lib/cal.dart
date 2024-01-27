import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  static const addSign = "\u002B";
  static const subtractSign = "\u2212";
  static const multiplySign = "\u00D7";
  static const divideSign = "\u00F7";
  static const equalSign = "\u003D";

  String displayValue = "0";

  void addOperator(String operator) {
    setState(() {
      if (operator == 'C') {
        displayValue = '0'; // Reset displayValue to '0' when 'C' is pressed
      } else {
        if (displayValue == '0') {
          displayValue = operator; // Replace '0' with the first entered number/operator
        } else {
          displayValue += operator; // Append operator otherwise
        }
      }
    });
  }

  Widget buildCal({
    required dynamic label,
    Color color = Colors.black,
  }) {
    String text = '';

    if (label is IconData) {
      text = label.codePoint.toString();
    } else if (label is String) {
      text = label;
    }
    if (label == addSign || label == subtractSign || label == multiplySign || label == divideSign) {
      // Set the color to blue for add, subtract, multiply, and divide buttons
      color = Colors.blue;
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: TextButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(50.0, 70.0)),
            ),
            onPressed: () {
              addOperator(text);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (label is IconData) Icon(label, color: color),
                if (label is String)
                  Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontSize: 20.0,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFunctionButton(IconData icon, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: TextButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(50.0, 70.0)),
            ),
            onPressed: onPressed,
            child: Icon(
              icon,
              size: 20.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Display at the top with some padding
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              displayValue,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 32.0,
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.green,
                  ),
                  child: buildCal(
                    label: 'C',
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.green,
                  ),
                  child: buildFunctionButton(Icons.backspace_outlined, () {
                    setState(() {
                      if (displayValue.length > 0) {
                        displayValue = displayValue.substring(0, displayValue.length - 1);
                      }
                    });
                  }),
                ),
              ),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              buildCal(label: '7'),
              SizedBox(width: 7),
              buildCal(label: '8'),
              SizedBox(width: 7),
              buildCal(label: '9'),
              SizedBox(width: 7),
              buildFunctionButton(Icons.clear, () => addOperator(divideSign)),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              buildCal(label: '4'),
              SizedBox(width: 7),
              buildCal(label: '5'),
              SizedBox(width: 7),
              buildCal(label: '6'),
              SizedBox(width: 7),
              buildFunctionButton(Icons.clear, () => addOperator(multiplySign)),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              buildCal(label: '1'),
              SizedBox(width: 7),
              buildCal(label: '2'),
              SizedBox(width: 7),
              buildCal(label: '3'),
              SizedBox(width: 7),
              buildFunctionButton(Icons.clear, () => addOperator(subtractSign)),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              buildCal(label: '0'),
              SizedBox(width: 7),
              buildFunctionButton(Icons.clear, () => addOperator(addSign)),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              buildFunctionButton(Icons.clear, () => addOperator(equalSign)),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Calculator(),
  ));
}
