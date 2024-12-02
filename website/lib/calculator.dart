import 'package:flutter/material.dart';

void main() => runApp(Calcutor());

class Calcutor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      home: CalcutorScreen(),
    );
  }
}

class CalcutorScreen extends StatefulWidget {
  @override
  _CalcutorScreenState createState() =>
      _CalcutorScreenState();
}

class _CalcutorScreenState extends State<CalcutorScreen> {
  double? num1;
  double? num2;
  String? operator;
  String result = "0";

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        num1 = null;
        num2 = null;
        operator = null;
        result = "0";
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        if (num1 != null) {
          operator = value;
        }
      } else if (value == '=') {
        if (num1 != null && num2 != null && operator != null) {
          switch (operator) {
            case '+':
              result = (num1! + num2!).toString();
              break;
            case '-':
              result = (num1! - num2!).toString();
              break;
            case '*':
              result = (num1! * num2!).toString();
              break;
            case '/':
              result = (num2 != 0 ? (num1! / num2!).toString() : 'Error');
              break;
          }
          num1 = null;
          num2 = null;
          operator = null;
        }
      } else {
        if (operator == null) {
          num1 = (num1 ?? 0) * 10 + double.parse(value);
          result = num1.toString();
        } else {
          num2 = (num2 ?? 0) * 10 + double.parse(value);
          result = num2.toString();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            result,
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              for (var row in [
                ['7', '8', '9'],
                ['4', '5', '6'],
                ['1', '2', '3'],
                ['C', '0', '=']
              ])
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: row
                      .map((button) => ElevatedButton(
                            onPressed: () => onButtonPressed(button),
                            child: Text(button, style: TextStyle(fontSize: 24)),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(70, 70),
                            ),
                          ))
                      .toList(),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['+', '-', '*', '/']
                    .map((button) => ElevatedButton(
                          onPressed: () => onButtonPressed(button),
                          child: Text(button, style: TextStyle(fontSize: 24)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(70, 70),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
