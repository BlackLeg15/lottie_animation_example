import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  var repeating = false;
  final animationUrl = 'https://assets4.lottiefiles.com/packages/lf20_0LAKyhkZmc.json';

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.network(
              animationUrl,
              controller: animationController,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              if (animationController.isAnimating) {
                repeating = false;
                animationController.reset();
              } else {
                repeating = true;
                animationController.repeat();
              }
            },
            tooltip: 'Repeat & Reset',
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                if (animationController.isAnimating) {
                  return const Icon(Icons.pause);
                } else {
                  return const Icon(Icons.play_arrow);
                }
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              if (animationController.isAnimating) return;
              if (animationController.isCompleted) {
                animationController.reverse();
              } else {
                animationController.forward();
              }
            },
            tooltip: 'Forward & Reverse',
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                if (repeating) {
                  return const CircularProgressIndicator(color: Colors.white);
                }
                switch (animationController.status) {
                  case AnimationStatus.forward:
                    return Transform.rotate(
                      angle: pi * animationController.value,
                      child: const Icon(Icons.arrow_forward),
                    );
                  case AnimationStatus.reverse:
                    return Transform.rotate(
                      angle: pi * (2 - animationController.value),
                      child: const Icon(Icons.arrow_forward),
                    );
                  case AnimationStatus.dismissed:
                    return const Icon(Icons.arrow_forward);
                  case AnimationStatus.completed:
                    return const Icon(Icons.arrow_back);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
