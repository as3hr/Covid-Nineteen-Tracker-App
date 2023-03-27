import 'dart:async';
import 'package:covid_nineteen/View/world_stats.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WorldStats())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: controller.value * 2.0 * math.pi,
                    child: child,
                  );
                },
                child: const SizedBox(
                  height: 200,
                  width: 200,
                  child: Center(
                      child: Image(
                    image: AssetImage('images/virus.png'),
                  )),
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            const Center(
                child: Text(
              'Covid19\n Tracker App',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
          ]),
    );
  }
}
