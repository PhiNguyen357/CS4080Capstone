import 'package:flutter/material.dart';
import 'page1.dart'; // Import your Page1
import 'page2.dart'; // Import your Page2
import 'page3.dart'; // Import your Page3

class Page4 extends StatefulWidget {
  const Page4({super.key});

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CS 4080'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Wheel Spin'),
            Tab(text: 'Calculator'),
            Tab(text: 'Dice Roll'),
            Tab(text: 'About'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const Page1(title: 'Random Wheel Spinner'), // Page1 content
          Page2(), // Page2 content
          const Page3(), // Page3 content
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Stretch to fit the width
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: const Text(
                  'This is a demo on how Dart and Flutter can be used for websites',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
