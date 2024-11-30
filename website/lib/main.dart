import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Wheel Spinner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Random Wheel Spinner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final Random _random = Random();
  int _spinResult = 0; // Result after the spin
  double _startAngle = 0; // Starting angle of the wheel
  double _endAngle = 0; // Ending angle of the wheel

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _spinResult = ((_endAngle % (2 * pi)) / (2 * pi / 8)).floor() + 1;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _spinWheel() {
    setState(() {
      _startAngle = _endAngle;
      _endAngle = _startAngle + 2 * pi * 5 + _random.nextDouble() * 2 * pi;
      _animation = Tween<double>(begin: _startAngle, end: _endAngle).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      );
      _spinResult = 0; // Reset result until the spin stops
    });
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Spin the wheel and see where it lands!',
            ),
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                // Arrow pointing to the result
                const Positioned(
                  top: 120, // Adjust this value to ensure the arrow aligns with the top
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 40,
                    color: Colors.red,
                  ),
                ),
                // The spinning wheel
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animation.value,
                      child: child,
                    );
                  },
                  child: _buildWheel(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _spinResult == 0
                  ? 'Spinning...'
                  : 'Spin Result: $_spinResult',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _spinWheel,
              child: const Text('Spin the Wheel'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWheel() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.deepPurple,
      ),
      child: Stack(
        children: List.generate(8, (index) {
          final double angle = (index * pi / 4);
          return Transform.rotate(
            angle: angle,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 50,
                height: 100,
                color: index % 2 == 0 ? Colors.amber : Colors.blue,
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
