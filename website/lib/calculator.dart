import 'package:flutter/material.dart';

void main() => runApp(Calcutor());

class Calcutor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
        home: CalcutorScreen(),
          child: SimpleCalculatorScreen(),
        ),
      ),
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
      return Container(
        width: 320, // Fixed width for the calculator
            padding: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
        decoration: BoxDecoration(
              color: Colors.white,
          color: Colors.white,
              borderRadius: BorderRadius.circular(16),
          borderRadius: BorderRadius.circular(16),
              boxShadow: [
          boxShadow: [
                BoxShadow(
            BoxShadow(
                  color: Colors.black26,
              color: Colors.black26,
                  blurRadius: 8,
              blurRadius: 8,
                  offset: Offset(0, 4),
              offset: Offset(0, 4),
                ),
              ],
            ),
          ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                result,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
               GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Four buttons in a row
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: 16,
                  itemBuilder: (context, index) {
                    final buttons = [
                      '7', '8', '9', '+',
                      '4', '5', '6', '-',
                      '1', '2', '3', '*',
                      'C', '0', '=', '/'
                    ];
                    final button = buttons[index];
                    return ElevatedButton(
                      onPressed: () => onButtonPressed(button),
                      child: Text(
                        button,
                        style: TextStyle(fontSize: 20), // Smaller font size
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(60, 60), // Smaller button size
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
