import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  Random random = Random();

  int counter = 1;
  int currentImageIndex = 0;

  List<String> images = [
    'assets/dice-six-faces-one.png',
    'assets/dice-six-faces-two.png',
    'assets/dice-six-faces-three.png',
    'assets/dice-six-faces-four.png',
    'assets/dice-six-faces-five.png',
    'assets/dice-six-faces-six.png',
  ];

  AudioPlayer audio = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice Roll'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(images[currentImageIndex], height:100),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () async {

              //sound
              await audio.setAsset('assets/roll.mp3');
              audio.play();

              //Roll Dice
              Timer.periodic(const Duration(milliseconds: 80), (timer) {
                counter++;
                setState((){
                  currentImageIndex = random.nextInt(6);
                });

                if(counter >= 13) {
                  timer.cancel();
                  setState((){
                    counter = 1;
                  });
                }
              });
            }, child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Roll',
                  style: TextStyle(fontSize: 26),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}