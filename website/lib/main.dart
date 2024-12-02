import 'package:flutter/material.dart';
import 'pages/page1.dart'; // Wheel Page
import 'pages/page2.dart';
import 'pages/page3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add your image here
            Image.asset(
              'assets/dartlogo.png',
              width: 1000,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Page1(title: 'Random Wheel Spinner'),
                  ),
                );
              },
              child: const Text('Random Number'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page2()),
                );
              },
              child: const Text('Go to Second Page'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page3()),
                );
              },
              child: const Text('Go to Third Page'),
            ),
          ],
        ),
      ),
    );
  }
}
